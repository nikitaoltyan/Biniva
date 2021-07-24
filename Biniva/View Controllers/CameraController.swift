//
//  CameraController.swift
//  Biniva
//
//  Created by Nick Oltyan on 23.07.2021.
//

import UIKit
import AVFoundation

class CameraController: UIViewController {
    
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
            .with(bgColor: .lightGray)
            .with(cornerRadius: 9)
        
        button.setTitle("Где я?", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFPro", size: 12)
        button.setTitleColor(Colors.background, for: .normal)
        
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
    
    lazy var photoView: UIView = {
        let view = UIView(frame: self.cameraView.frame)
            .with(autolayout: false)
            .with(bgColor: .blue)
        view.isHidden = true
        return view
    }()
    
    let mainButton: TakePhotoView = {
        let view = TakePhotoView()
            .with(autolayout: false)
        view.clipsToBounds = true
        return view
    }()
    
    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var previewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
        activateLayouts()
        view.backgroundColor = Colors.background
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
    func backAction() {
        print("backAction")
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func aboutAction() {
        print("aboutAction")
    }
    
    
    private
    func setUpCamera() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("Unable to access back camera")
            return
        }
        
        do {
            self.input = try AVCaptureDeviceInput(device: device)
            self.session?.addInput(self.input!)
            
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session!)
            self.previewLayer?.frame.size = self.cameraView.frame.size
            self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.cameraView.layer.addSublayer(self.previewLayer!)
            
            self.session?.startRunning()
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
}





extension CameraController {
    
    func setSubviews(){
        view.addSubview(backButton)
        view.addSubview(aboutButton)
        view.addSubview(cameraView)
        view.addSubview(photoView)
        view.addSubview(mainButton)
        
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
        aboutButton.addTarget(self, action: #selector(aboutAction), for: .touchUpInside)
    }
    
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
            
            photoView.topAnchor.constraint(equalTo: cameraView.topAnchor),
            photoView.leftAnchor.constraint(equalTo: cameraView.leftAnchor),
            photoView.rightAnchor.constraint(equalTo: cameraView.rightAnchor),
            photoView.bottomAnchor.constraint(equalTo: cameraView.bottomAnchor),
            
            mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainButton.topAnchor.constraint(equalTo: cameraView.bottomAnchor, constant: 24),
            mainButton.widthAnchor.constraint(equalToConstant: mainButton.frame.width),
            mainButton.heightAnchor.constraint(equalToConstant: mainButton.frame.height),
        ])
    }
}
