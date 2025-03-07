//
//  UIView+img.swift
//  PokerZoneLili
//
//  Created by PokerZoneLili on 2025/3/7.
//


import UIKit

extension UIView {
    
    func toImage() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        layer.render(in: context)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        
        guard let pngData = image.pngData() else { return nil }
        
        return UIImage(data: pngData)
    }
}
