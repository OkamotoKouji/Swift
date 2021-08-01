//
//  UIImageExtension.swift
//  Camera
//
//  Created by 岡本幸二 on 2021/07/29.
//

import Foundation
import UIKit

extension UIImage {
    func resize() -> UIImage? {
        let rate = 1024.0 / self.size.width
        let rect = CGRect(x: 0, y: 0, width: self.size.width * rate, height: self.size.height)
        
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
