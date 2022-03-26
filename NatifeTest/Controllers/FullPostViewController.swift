//
//  FullPostViewController.swift
//  NatifeTest
//
//  Created by Mykhailo Petukhov on 25.03.2022.
//

import Foundation
import UIKit

class FullPostViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imagesStackView: UIStackView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Constants
    let imageService = ImageService()
    let dateService = DateService()
    
    // MARK: - Variables
    var post: FullPost!
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUiFromPost()
    }
    
    private func initUiFromPost() {
        URLCache.shared.removeAllCachedResponses()
        
        title = post.title
        titleLabel.text = post.title
        textLabel.text = post.text
        likesLabel.text = "\(post.likesCount)"
        
        let diff = dateService.getDifferenceBetween(unixEpoch: post.timeshamp, and: Date())
        if let diffString = dateService.getDateStringFrom(timeInterval: diff) {
            timeLabel.text = "\(diffString) назад"
        } else {
            timeLabel.text = ""
        }
        
        fetchAndSetImagesFromPost()
    }
    
    private func fetchAndSetImagesFromPost() {
        for imageUrl in post.images {
            let view = UIActivityIndicatorView()
            view.startAnimating()
            imagesStackView.addArrangedSubview(view)
            
            imageService.fetchImage(from: imageUrl) { [weak self] image in
                if let image = image {
                    if let imageView = self?.getImageViewFor(image: image) {
                        self?.imagesStackView.addArrangedSubview(imageView)
                    }
                } else {
                    if let imageView = self?.getImageViewFor(image: UIImage(named: "noImage.svg")!) {
                        self?.imagesStackView.addArrangedSubview(imageView)
                    }
                }
                self?.imagesStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
    }
    
    private func getImageViewFor(image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.constraintAspectRatioToImage()
        
        return imageView
    }
}
