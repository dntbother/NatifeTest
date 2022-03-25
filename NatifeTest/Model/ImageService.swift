//
//  ImageService.swift
//  NatifeTest
//
//  Created by Mykhailo Petukhov on 25.03.2022.
//

import Foundation
import Alamofire

class ImageService {
    func fetchImage(from url: String, completion: @escaping (UIImage?)->Void) {
        let request = AF.request(url)

        request.responseData { data in
            if let data = data.data {
                let image = UIImage(data: data, scale: 1)
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
