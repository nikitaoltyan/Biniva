//
//  DefaultPin.swift
//  GreenerCo
//
//  Created by Никита Олтян on 22.05.2021.
//

import MapKit

class PlasticAnnotationView: MKMarkerAnnotationView {

    static let ReuseID = "plactisAnnotation"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = false
        clusteringIdentifier = "cluster"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultLow
        markerTintColor = .blue
        glyphImage = UIImage(systemName: "trash")
        glyphImage?.withTintColor(Colors.background)
    }
}


class OrganicAnnotationView: MKMarkerAnnotationView {

    static let ReuseID = "organicAnnotation"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = false
        clusteringIdentifier = "cluster"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultHigh
        markerTintColor = .green
        glyphImage = UIImage(systemName: "trash")
        glyphImage?.withTintColor(Colors.background)
    }
}

class PaperAnnotationView: MKMarkerAnnotationView {

    static let ReuseID = "paperAnnotation"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = false
        clusteringIdentifier = "cluster"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultHigh
        markerTintColor = .brown
        glyphImage = UIImage(systemName: "trash")
        glyphImage?.withTintColor(Colors.background)
    }
}




class DefaultAnnotationView: MKAnnotationView {

    let functions = MaterialFunctions()
    static let ReuseID = "defaultAnnotation"
    
    var types: [TrashType] = []
    
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
            let initColor: UIColor = functions.colorByRowValue(types[0].rawValue)
            initColor.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size, height: size)).fill()

            // Fill pie with fractionColor
            let fractionColor: UIColor = functions.colorByRowValue(types[1].rawValue)
            fractionColor.setFill()
            let piePath = UIBezierPath()
            piePath.addArc(withCenter: CGPoint(x: size/2, y: size/2), radius: size/2,
                           startAngle: 0, endAngle: (CGFloat.pi * 2.0 * CGFloat(1)) / CGFloat(2),
                           clockwise: true)
            piePath.addLine(to: CGPoint(x: size/2, y: size/2))
            piePath.close()
            piePath.fill()

            let useImage = UIImage(systemName: "trash")?.withTintColor(Colors.background)
            useImage?.draw(in: rect)
        }
    }
}
