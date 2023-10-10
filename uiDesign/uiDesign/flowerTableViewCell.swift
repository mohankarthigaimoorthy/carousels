//
//  flowerTableViewCell.swift
//  uiDesign
//
//  Created by Imcrinox Mac on 31/05/23.
//

import UIKit

class flowerTableViewCell: UITableViewCell {

    @IBOutlet weak var floImg: UIImageView!
    @IBOutlet weak var tex1: UILabel!
    @IBOutlet weak var tex2: UILabel!
    @IBOutlet weak var tex3: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
