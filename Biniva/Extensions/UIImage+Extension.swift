//
//  UIImage+Extension.swift
//  Biniva
//
//  Created by Nick Oltyan on 28.06.2021.
//

import UIKit

extension UIImage {

    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
