//
//  DefaultPin.swift
//  GreenerCo
//
//  Created by Никита Олтян on 22.05.2021.
//

import MapKit


class DefaultAnnotationView: MKAnnotationView {

    let functions = MaterialFunctions()
    static let ReuseID = "defaultAnnotation"
    
    var types: [Int] = []
    var pointID: String?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = "cluster"
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultLow
        if let annotation = annotation as? TrashBin {
            self.types = annotation.types
            image = drawRatio()
        }
    }
    
    
    private
    func drawRatio() -> UIImage {
        let size: CGFloat = 32
        let delta: CGFloat = 10
        let rect = CGRect(x: delta/2, y: delta/2, width: size-delta, height: size-delta)
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
        
        guard types.count > 0 else {
            return renderer.image { _ in
                UIColor.gray.setFill()
                UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size, height: size)).fill()
            }
        }
        
        return renderer.image { (_) in
            // Fill full circle with wholeColor
            let initColor: UIColor = functions.colorByRowValue(types[0])
            initColor.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size, height: size)).fill()

            // Fill pie with fractionColor
            for (item, type) in types.enumerated() {
                let fractionColor: UIColor = functions.colorByRowValue(type)
                fractionColor.setFill()
                
                let piePath = UIBezierPath()
                piePath.addArc(withCenter: CGPoint(x: size/2, y: size/2), radius: size/2,
                               startAngle: (CGFloat.pi * 2.0 * CGFloat(item)) / CGFloat(types.count),
                               endAngle: (CGFloat.pi * 2.0 * CGFloat(item+1)) / CGFloat(types.count),
                               clockwise: true)
                
                piePath.addLine(to: CGPoint(x: size/2, y: size/2))
                piePath.close()
                piePath.fill()
            }

            let useImage = UIImage(systemName: "trash")?.withTintColor(Colors.background)
            useImage?.draw(in: rect)
        }
    }
}
