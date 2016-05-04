//
//  PPicImageView.swift
//  DemoSEAPI
//
//  Created by ashiq on 04/05/16.
//  Copyright © 2016 ashiq. All rights reserved.
//

import UIKit

protocol PPicImageViewDelegate {
    func ppicTapped()
}

class PPicImageView: UIImageView {

    weak var delegate : MainTableViewCell? = nil
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("PPic touched")
       delegate!.ppicTapped();
    }

}
