//
//  placestblCell.swift
//  Hostels Hub
//
//  Created by Apple on 14/10/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class placestblCell: UITableViewCell {

    @IBOutlet weak var distancelbl: UILabel!
    @IBOutlet weak var addresslbl: UILabel!
    @IBOutlet weak var placenamelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
