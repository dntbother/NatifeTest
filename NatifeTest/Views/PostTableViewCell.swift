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
    @IBOutlet weak var previewTextLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var tableView: UITableView!
    var postId: Int!
    var delegate: CellExpantionDelegate!
    
    @IBAction func showButtonTapped(_ sender: UIButton) {
        expandSummaryAndHideButton()
        delegate.cellExpanded(postId)
    }
    
    func expandSummaryAndHideButton() {
        previewTextLabel.numberOfLines = 0
        showButton.isHidden = true
    }
    
    func collapseSummaryAndShowButton() {
        previewTextLabel.numberOfLines = 2
        showButton.isHidden = false
    }
}
