

import UIKit

class MessageCell: UITableViewCell {

    // MARK:- OUTLETS AND VARIABLES
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var checkBtn:UIButton!
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var messageLbl: UILabel!
    
    //MARK:- PROPERTIES
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.height/8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
