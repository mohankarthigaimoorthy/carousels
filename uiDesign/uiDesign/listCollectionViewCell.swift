//
//  listCollectionViewCell.swift
//  uiDesign
//
//  Created by Imcrinox Mac on 30/05/23.
//

import UIKit

class listCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dash: UILabel!
//    
//    
//    override var isSelected: Bool {
//        didSet {
//            title.textColor = isSelected ? .black : .red
//        }
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        title.textColor = .black
//        title.highlightedTextColor = .red
    }
}
