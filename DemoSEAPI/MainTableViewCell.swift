//
//  MainTableViewCell.swift
//  DemoSEAPI
//
//  Created by ashiq on 15/03/16.
//  Copyright © 2016 ashiq. All rights reserved.
//

import UIKit

protocol MainTableViewCellDelegate {    
    func profilePicTouchedAtIndex(index: Int)
}

//MainTableViewCell adopts to the PPicImageViewDelegate protocol

class MainTableViewCell: UITableViewCell, PPicImageViewDelegate {

    weak var delegates : MainTableViewController? = nil

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var avatarLabel: PPicImageView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    //@IBOutlet weak var imageButton: UIButton!
    var rowIndex: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarLabel.delegate = self
    }
    
    // adopts to the PPicImageViewDelegate protocol by implementing the pic tapped function
    func ppicTapped() {
        print(rowIndex)
        delegates!.profilePicTouchedAtIndex(rowIndex)
    }
}
