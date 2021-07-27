//
//  CameraController.swift
//  Biniva
//
//  Created by Nick Oltyan on 23.07.2021.
//

import UIKit
import AVFoundation

protocol bottomCameraDelegate {
    func takePhoto()
    func addMaterial(material: Int, weight: Int)
    func showAlert(withTitle title: String, andSubtitle subtitle: String)
}

protocol alertCameraDelegate {
    func closeAlert()
}

class CameraController: UIViewController {
    
    let analytics = ServerAnalytics()
    let server = Server()
    let database = DataFunction()
    
    let backButton: UIImageView = {
        let scale: CGFloat = {
            if MainConstants.screenHeight > 700 { return 35 }
            else { return 27 }
        }()
        let button = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale-5))
            .with(autolayout: false)
        button.tintColor = MainConstants.nearBlack
        button.image = UIImage(systemName: "chevron.down")
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let aboutButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 85, height: 30))
            .with(autolayout: false)
            .with(bgColor: Colors.sliderGray)
            .with(cornerRadius: 9)
        
        button.setTitle("Где я?", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFPro", size: 12)
        button.setTitleColor(Colors.nearBlack, for: .normal)
        
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()
    
    let cameraView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 570))
            .with(autolayout: false)
            .with(bgColor: Colors.sliderGray)
        return view
    }()
    
    lazy var flashView: UIView = {
        let view = UIView(frame: self.cameraView.frame)
            .with(autolayout: false)
            .with(bgColor: Colors.background)
        view.isHidden = true
        return view
    }()
    
    lazy var photoView: UIImageView = {
        let view = UIImageView(frame: self.cameraView.frame)
            .with(autolayout: false)
            .with(bgColor: Colors.background)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.isHidden = true
        return view
    }()
    
    lazy var bottomView: BottomCameraView = {
        let view = BottomCameraView()
            .with(autolayout: false)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.delegate = self
        return view
    }()
    
    lazy var alertView: AlertCameraView = {
        let view = AlertCameraView()
            .with(autolayout: false)
        view.isHidden = true
        view.delegate = self
        return view
    }()
    
    var statsDelegate: Test?
    var recyclingDelegate: recyclingProgressDelegate?
    
    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var output: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var alertCenterXConstraint: NSLayoutConstraint?
    var bottomViewHeightConstraint: NSLayoutConstraint?
    var isPhotoTaken: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
        activateLayouts()
        view.backgroundColor = Colors.background
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.previewLayer?.frame.size = self.cameraView.frame.size
        session = AVCaptureSession()
        setUpCamera()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.session?.stopRunning()
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    
    @objc
    func backAction() {
        print("backAction")
        if (isPhotoTaken) {
            photoView.isHidden = true
            isPhotoTaken = false
            bottomView.backAnimate()
            narrowBottomView()
            backButton.rotate(forPosition: .horizontal)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc
    func aboutAction() {
        print("aboutAction")
        aboutButton.tap(completion: { (_) in
            self.openAlert()
        })
    }
    
//    @objc
//    func draggedView(_ sender: UIPanGestureRecognizer){
//        view.bringSubviewToFront(alertView)
//        let translation = sender.translation(in: view)
//        guard translation.x < 0 else { return }
//
//        alertView.center = CGPoint(x: alertView.center.x + translation.x,
//                                    y: alertView.center.y)
//
//        sender.setTranslation(CGPoint.zero, in: view)
//        if (sender.state == .ended) {
//            closeAlert()
//        }
//    }
    
    
    private
    func setUpCamera() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("Unable to access back camera")
            return
        }
        
        do {
            self.input = try AVCaptureDeviceInput(device: device)
            self.output = AVCapturePhotoOutput()
            self.session?.addInput(self.input!)
            self.session?.addOutput(self.output!)
            
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session!)
            self.previewLayer?.frame.size = self.cameraView.frame.size
            self.previewLayer?.videoGravity = .resizeAspectFill
            self.cameraView.layer.addSublayer(self.previewLayer!)
            
            self.session?.startRunning()
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    private
    func extendBottomView() {
        bottomViewHeightConstraint?.constant += 70
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.bottomView.layer.cornerRadius = 20
        })
    }
    
    private
    func narrowBottomView() {
        bottomViewHeightConstraint?.constant -= 70
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.bottomView.layer.cornerRadius = 0
        })
    }

}





extension CameraController: AVCapturePhotoCaptureDelegate, bottomCameraDelegate {
    
    func takePhoto() {
        isPhotoTaken = true
        backButton.rotate(forPosition: .vertical)
        extendBottomView()
//        AudioServicesPlayAlertSound(1108)

        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        output?.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        let image = UIImage(data: imageData)
        photoView.image = image
        photoView.isHidden = false
    }
    
    
    func addMaterial(material: Int, weight: Int) {
        guard let image = photoView.image else { return }
        
        self.analytics.logCameraAddMaterial(type: material, size: weight)
        self.database.addData(loggedSize: weight, material: material, date: Date().onlyDate)
        
        DispatchQueue.main.async {
            self.server.createNewPhotoData(image, forMaterial: material, andWeight: weight)
        }
        
//            Call circle animation function here also.
        self.dismiss(animated: true, completion: {() in
            self.statsDelegate?.update()
            self.recyclingDelegate?.update(addWeight: weight)
        })
    }
    
    
    func showAlert(withTitle title: String, andSubtitle subtitle: String) {
        let alert = prepareAlert(withTitle: title,
                                 andSubtitle: subtitle,
                                 closeAction: NSLocalizedString("add_point_close_alert", comment: "Ask for change everything"))
        present(alert, animated: true, completion: nil)
    }
}






extension CameraController: alertCameraDelegate {
    func closeAlert() {
        self.alertCenterXConstraint?.constant = -MainConstants.screenWidth
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.alertView.isHidden = true
        })
    }
    
    func openAlert() {
        self.alertCenterXConstraint?.constant = 0
        alertView.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
}





extension CameraController {
    private
    func setSubviews(){
        view.addSubview(backButton)
        view.addSubview(aboutButton)
        view.addSubview(cameraView)
        cameraView.addSubview(flashView)
        view.addSubview(photoView)
        view.addSubview(alertView)
        view.addSubview(bottomView)
        
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
        aboutButton.addTarget(self, action: #selector(aboutAction), for: .touchUpInside)
//        alertView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:))))
    }
    
    private
    func activateLayouts(){
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            backButton.heightAnchor.constraint(equalToConstant: backButton.frame.height),
            backButton.widthAnchor.constraint(equalToConstant: backButton.frame.width),
            
            aboutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            aboutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            aboutButton.heightAnchor.constraint(equalToConstant: aboutButton.frame.height),
            aboutButton.widthAnchor.constraint(equalToConstant: aboutButton.frame.width),
            
            cameraView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cameraView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            cameraView.widthAnchor.constraint(equalToConstant: cameraView.frame.width),
            cameraView.heightAnchor.constraint(equalToConstant: cameraView.frame.height),
            
            flashView.centerXAnchor.constraint(equalTo: cameraView.centerXAnchor),
            flashView.centerYAnchor.constraint(equalTo: cameraView.centerYAnchor),
            flashView.widthAnchor.constraint(equalToConstant: flashView.frame.width),
            flashView.heightAnchor.constraint(equalToConstant: flashView.frame.height),
            
            photoView.topAnchor.constraint(equalTo: cameraView.topAnchor),
            photoView.leftAnchor.constraint(equalTo: cameraView.leftAnchor),
            photoView.rightAnchor.constraint(equalTo: cameraView.rightAnchor),
            photoView.bottomAnchor.constraint(equalTo: cameraView.bottomAnchor),
            
            // alertView centerXAnchor constraint in the bottom of the function.
            alertView.topAnchor.constraint(equalTo: cameraView.topAnchor, constant: 15),
            alertView.widthAnchor.constraint(equalToConstant: alertView.frame.width),
            alertView.heightAnchor.constraint(equalToConstant: alertView.frame.height),
            
            // bottomView height constraint in the bottom of the function.
            bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.widthAnchor.constraint(equalToConstant: bottomView.frame.width)
        ])
        
        bottomViewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: bottomView.frame.height)
        alertCenterXConstraint = alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -MainConstants.screenWidth)
        bottomViewHeightConstraint?.isActive = true
        alertCenterXConstraint?.isActive = true
    }
}
