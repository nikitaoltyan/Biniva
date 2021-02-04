//
//  CustomAddView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.11.2020.
//

import UIKit

class CustomAddView: UIView {
    
    var materials = [MaterialsObject]()
    
    let topView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 120))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.green
        return view
    }()
    
    let currentValueLabel: UILabel = {
        let label = UILabel()
            .with(alignment: .center)
            .with(color: MainConstants.white)
            .with(fontName: "SFPro-Medium", size: 22)
            .with(numberOfLines: 1)
        label.text = "200 гр Пластик"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 5
        slider.maximumValue = 1000
        slider.value = 200
        slider.tintColor = MainConstants.white
        return slider
    }()
    
    let plusView: CompletePlusView = {
        let scale: CGFloat = 28
        let view = CompletePlusView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
            .with(bgColor: MainConstants.white)
            .with(cornerRadius: scale/2)
        view.horizontalView.backgroundColor = MainConstants.green
        view.verticalView.backgroundColor = MainConstants.green
        return view
    }()
    
    let minusView: CompletePlusView = {
        let scale: CGFloat = 28
        let view = CompletePlusView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
            .with(bgColor: MainConstants.white)
            .with(cornerRadius: scale/2)
        view.horizontalView.backgroundColor = MainConstants.green
        view.verticalView.isHidden = true
        return view
    }()
    
    let selectedView: ItemView = {
        let width: CGFloat = {if MainConstants.screenHeight > 700 {return 50} else {return 40}}()
        let view = ItemView(frame: CGRect(x: 0, y: 0, width: width, height: width))
            .with(bgColor: MaterialsColors.waterBlue)
            .with(cornerRadius: width/3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image.image = MaterialsIcons.waterBottle
        return view
    }()
    
    let addView: CompletePlusView = {
        let scale: CGFloat = 40
        let view = CompletePlusView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
            .with(bgColor: MainConstants.white)
            .with(cornerRadius: 15)
        view.horizontalView.backgroundColor = MainConstants.green
        view.verticalView.backgroundColor = MainConstants.green
        return view
    }()
    
    let closeView: UIView = {
        let view = UIView()
            .with(bgColor: MainConstants.white)
            .with(cornerRadius: 2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = MainConstants.white
        table.register(CustomAddCell.self, forCellReuseIdentifier: "CustomAddCell")
        return table
    }()
    
    var selectedIndexPath: Int = 0
    var delegate: RecyclingDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    
    func PopulateMaterials(materialsObjectToPass useMeterials: NSObject){
        self.materials = useMeterials as! [MaterialsObject]
    }
    
    
    func ChangeCurrentItem(withIndexPath indexPath: Int){
        selectedView.image.image = materials[indexPath].image
        selectedView.backgroundColor = materials[indexPath].color
    }
    
    
    @objc func PlusAction() {
        Vibration.Soft()
        slider.value += 5
        currentValueLabel.text = "\(Int(slider.value)) гр \(materials[selectedIndexPath].name ?? "Not Stated")"
    }
    
    
    @objc func MinusAction() {
        Vibration.Soft()
        slider.value -= 5
        currentValueLabel.text = "\(Int(slider.value)) гр \(materials[selectedIndexPath].name ?? "Not Stated")"
    }
    
    
    @objc func AddItem() {
        print("Add item")
        delegate?.LogValue(withSize: Int(slider.value), andMaterial: materials[selectedIndexPath].name ?? "Not Stated")
    }

    
    @objc func SliderValueChanged() {
        let roundedValue = round(slider.value / 5) * 5
        if roundedValue-0.5...roundedValue+0.5 ~= slider.value { Vibration.Soft() }
        slider.value = roundedValue
        currentValueLabel.text = "\(Int(roundedValue)) гр \(materials[selectedIndexPath].name ?? "Not Stated")"
    }
}







extension CustomAddView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomAddCell") as! CustomAddCell
        cell.itemView.backgroundColor = materials[indexPath.row].color
        cell.itemView.image.image = materials[indexPath.row].image
        cell.itemLabel.text = materials[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath.row
        SliderValueChanged()
        ChangeCurrentItem(withIndexPath: indexPath.row)
    }
}






extension CustomAddView{
    func SetSubviews(){
        self.addSubview(topView)
        self.addSubview(selectedView)
        self.addSubview(addView)
        self.addSubview(slider)
        self.addSubview(plusView)
        self.addSubview(minusView)
        self.addSubview(currentValueLabel)
        self.addSubview(closeView)
        self.addSubview(table)
        
        slider.addTarget(self, action: #selector(SliderValueChanged), for: .valueChanged)
        plusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PlusAction)))
        minusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MinusAction)))
        addView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddItem)))
    }
    
    
    func ActivateLayouts(){
        let tableHeight: CGFloat = self.frame.size.height - topView.frame.height
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leftAnchor.constraint(equalTo: self.leftAnchor),
            topView.rightAnchor.constraint(equalTo: self.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: topView.frame.height),
            
            selectedView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            selectedView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            selectedView.heightAnchor.constraint(equalToConstant: selectedView.frame.height),
            selectedView.widthAnchor.constraint(equalToConstant: selectedView.frame.width),
            
            addView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            addView.centerYAnchor.constraint(equalTo: selectedView.centerYAnchor),
            addView.heightAnchor.constraint(equalToConstant: addView.frame.height),
            addView.widthAnchor.constraint(equalToConstant: addView.frame.width),
            
            slider.topAnchor.constraint(equalTo: selectedView.bottomAnchor, constant: 7),
            slider.leftAnchor.constraint(equalTo: selectedView.rightAnchor, constant: -20),
            slider.rightAnchor.constraint(equalTo: addView.leftAnchor, constant: 20),
            slider.heightAnchor.constraint(equalToConstant: 40),
            
            plusView.leftAnchor.constraint(equalTo: slider.rightAnchor, constant: 2),
            plusView.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            plusView.heightAnchor.constraint(equalToConstant: plusView.frame.height),
            plusView.widthAnchor.constraint(equalToConstant: plusView.frame.width),
            
            minusView.rightAnchor.constraint(equalTo: slider.leftAnchor, constant: -2),
            minusView.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            minusView.heightAnchor.constraint(equalToConstant: minusView.frame.height),
            minusView.widthAnchor.constraint(equalToConstant: minusView.frame.width),
            
            currentValueLabel.centerXAnchor.constraint(equalTo: slider.centerXAnchor),
            currentValueLabel.bottomAnchor.constraint(equalTo: selectedView.bottomAnchor),
            
            closeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            closeView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            closeView.widthAnchor.constraint(equalToConstant: 30),
            closeView.heightAnchor.constraint(equalToConstant: 5),
            
            table.topAnchor.constraint(equalTo: topView.bottomAnchor),
            table.leftAnchor.constraint(equalTo: self.leftAnchor),
            table.rightAnchor.constraint(equalTo: self.rightAnchor),
            table.heightAnchor.constraint(equalToConstant: tableHeight)
        ])
    }
}
