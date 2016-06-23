//
//  PersonalCell.swift
//  Parsetagram
//
//  Created by Baula Xu on 6/22/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PersonalCell: UITableViewCell {
    @IBOutlet weak var usernameLabel2: UILabel!
    @IBOutlet weak var overviewLabel2: UILabel!
    @IBOutlet weak var imageLabel2: PFImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
