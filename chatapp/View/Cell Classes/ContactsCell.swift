//
//  ContactsCell.swift
//  chatapp
//
//  Created by Vishavesh Tyagi on 24/08/21.
//

import UIKit

class ContactsCell: UITableViewCell {

    // MARK:- OUTLETS AND VARIABLES
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    
    //MARK:- PROPERTIES
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
