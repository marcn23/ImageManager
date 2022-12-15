//
//  StyledTextFile.swift
//  ImageManager
//
//  Created by albert on 15/12/22.
//

import Foundation
import UIKit

class StyledTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: t.frame.height))
        self.leftViewMode = .always
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: t.frame.height))
        self.rightViewMode = .always
        self.clearButtonMode = .whileEditing
    }
}
