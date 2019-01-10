//
//  MycustomTableViewCell.swift
//  final
//
//  Created by User15 on 2019/1/7.
//  Copyright © 2019 ee. All rights reserved.
//

import UIKit

class MycustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lll: UIImageView!
    @IBOutlet weak var llk: UILabel!
    @IBOutlet weak var Timelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
