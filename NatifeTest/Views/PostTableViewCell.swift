//
//  PostTableViewCell.swift
//  NatifeTest
//
//  Created by Mykhailo Petukhov on 25.03.2022.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func showButtonTapped(_ sender: UIButton) {
        expandSummaryAndHideButton()
    }
    
    func expandSummaryAndHideButton() {
        summaryLabel.numberOfLines = 0
        
        UIView.animate(withDuration: 1) { [weak self] in
            self?.layoutIfNeeded()
            self?.showButton.isHidden = true
        }
    }
    
    func collapseSummaryAndShowButton() {
        summaryLabel.numberOfLines = 2
        showButton.isHidden = false
    }
}
