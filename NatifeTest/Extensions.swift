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
