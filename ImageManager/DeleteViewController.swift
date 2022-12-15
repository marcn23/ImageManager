//
//  DeleteViewController.swift
//  ImageManager
//
//  Created by albert on 15/12/22.
//

import Foundation
import UIKit

class DeleteViewController: UIViewController {

    var label: UILabel!
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        label = UILabel(frame: CGRect(x:70,y:220,width:500,height:50))
        label.text = "IMAGEN ELIMINADA"
        label.font = label.font.withSize(30)
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        
        button = UIButton(frame: CGRect(x:150,y:310,width:100,height:50))
        button.setTitle("OK", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(20)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(ClickedButton), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    @objc func ClickedButton(){
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
