//
//  Extensions.swift
//  NatifeTest
//
//  Created by Mykhailo Petukhov on 25.03.2022.
//

import Foundation
import UIKit

extension UIImageView {
    func constraintAspectRatioToImage() {
        if let image = self.image {
            let size = image.size
            let aspectRatio = size.height/size.width
            self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: aspectRatio).isActive = true
        }
    }
}

extension Double {
    func convertUnixEpochToDate() -> Date {
        return Date(timeIntervalSince1970: self)
    }
}

extension UIView {
    func fadeIn(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
        self.alpha = 0
        self.isHidden = false
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 1 },
                       completion: { (value: Bool) in
                        if let complete = onCompletion { complete() }
                       }
        )
    }
    
    func fadeOut(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 0 },
                       completion: { (value: Bool) in
                        self.isHidden = true
                        if let complete = onCompletion { complete() }
                       }
        )
    }
}
