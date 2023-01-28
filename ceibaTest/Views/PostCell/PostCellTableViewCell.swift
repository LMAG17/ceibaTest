//
//  PostCellTableViewCell.swift
//  ceibaTest
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//

import UIKit

class PostCellTableViewCell: UITableViewCell {

    //MARK: -> Content Variable
    var titleText : String?
    var descriptionText: String?
    
    // MARK: -> Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: -> awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: -> setSelected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        titleLabel.text = titleText ?? ""
        descriptionLabel.text = descriptionText ?? ""
    }
    
}
