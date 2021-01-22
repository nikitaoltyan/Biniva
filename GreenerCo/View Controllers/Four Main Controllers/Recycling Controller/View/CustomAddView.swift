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
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.green
        return view
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 20
        slider.minimumValue = 10
        slider.value = 15
        slider.tintColor = MainConstants.white
        return slider
    }()
    
    let selectedView: AddItemView = {
        let width: CGFloat = {if MainConstants.screenHeight > 700 {return 50} else {return 40}}()
        let view = AddItemView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = width/3
        view.backgroundColor = MaterialsColors.waterBlue
        view.image.image = MaterialsIcons.waterBottle
        return view
    }()
    
    let plusView: CompletePlusView = {
        let scale: CGFloat = 40
        let view = CompletePlusView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        view.layer.cornerRadius = 15
        view.backgroundColor = MainConstants.white
        view.horizontalView.backgroundColor = MainConstants.green
        view.verticalView.backgroundColor = MainConstants.green
        return view
    }()
    
    let closeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.white
        view.layer.cornerRadius = 2
        return view
    }()
    
    lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = MainConstants.white
        return table
    }()
    
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
    
    @objc func AddItem(){
        print("Add item")
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
        cell.itemImage.image = materials[indexPath.row].image
        cell.itemColorView.backgroundColor = materials[indexPath.row].color
        cell.itemLabel.text = materials[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ChangeCurrentItem(withIndexPath: indexPath.row)
    }
    
    
}





extension CustomAddView{
    func SetSubviews(){
        self.addSubview(topView)
        self.addSubview(selectedView)
        self.addSubview(plusView)
        self.addSubview(slider)
        self.addSubview(closeView)
        self.addSubview(table)
        
        table.register(CustomAddCell.self, forCellReuseIdentifier: "CustomAddCell")
        plusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddItem)))
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leftAnchor.constraint(equalTo: self.leftAnchor),
            topView.rightAnchor.constraint(equalTo: self.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: 80),
            
            selectedView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            selectedView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            selectedView.heightAnchor.constraint(equalToConstant: selectedView.frame.height),
            selectedView.widthAnchor.constraint(equalToConstant: selectedView.frame.width),
            
            plusView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            plusView.centerYAnchor.constraint(equalTo: selectedView.centerYAnchor),
            plusView.heightAnchor.constraint(equalToConstant: plusView.frame.height),
            plusView.widthAnchor.constraint(equalToConstant: plusView.frame.width),
            
            slider.centerYAnchor.constraint(equalTo: selectedView.centerYAnchor, constant: 7),
            slider.leftAnchor.constraint(equalTo: selectedView.rightAnchor, constant: 10),
            slider.rightAnchor.constraint(equalTo: plusView.leftAnchor, constant: -10),
            slider.heightAnchor.constraint(equalToConstant: 50),
            
            closeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            closeView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            closeView.widthAnchor.constraint(equalToConstant: 30),
            closeView.heightAnchor.constraint(equalToConstant: 5),
            
            table.topAnchor.constraint(equalTo: topView.bottomAnchor),
            table.leftAnchor.constraint(equalTo: self.leftAnchor),
            table.rightAnchor.constraint(equalTo: self.rightAnchor),
            table.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
