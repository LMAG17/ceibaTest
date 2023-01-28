//
//  UserCellViewCell.swift
//  ceibaTest
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//

import UIKit

class PersonCellViewCell: UITableViewCell {
    
    //MARK: -> Content Variable
    var name : String?
    var cellphone : String?
    var email : String?
    
    //MARK: -> Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellPhoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    //MARK: -> awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //MARK: -> setSelected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        nameLabel.text = name ?? ""
        cellPhoneLabel.text = cellphone ?? ""
        emailLabel.text = email ?? ""
    }
    
}
