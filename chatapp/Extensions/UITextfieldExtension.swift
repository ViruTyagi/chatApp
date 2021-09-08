//
//  UITextfieldExtension.swift
//  chatapp
//
//  Created by Vishavesh Tyagi on 26/08/21.
//

import UIKit

extension UITextField {
    
    func addleftPadding(){
        self.layer.cornerRadius = self.frame.height/2
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = view
        self.leftViewMode = .always
    }
    
    func attPlaceholder(placeholder: String){
        let attributes: [NSAttributedString.Key: Any] = [
            .font : UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.systemGray2
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        
    }

}
