
//
//  DeleteViewController.swift
//  ImageManager
//
//  Created by albert on 15/12/22.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {

    var label: UILabel!
    var button: UIButton!
    
    var imgpick: UIButton!
    var imgpicktf: UITextField!
    
    var autor: UITextField!
    var labelautor:UILabel!
    
    var titol: UITextField!
    var labeltitol:UILabel!
    
    var keywords: UITextField!
    var labelkeywords:UILabel!
    
    var labeldate:UILabel!
    
    var date: UIDatePicker!
  
    var filename: UITextField!
    var labelfilename:UILabel!
    
    var imatgepick: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        label = UILabel(frame: CGRect(x:60,y:175,width:500,height:50))
        label.text = "REGISTRAR IMAGEN"
        label.font = label.font.withSize(30)
        view.addSubview(label)
        
        labelautor = UILabel(frame: CGRect(x:10,y:340,width:500,height:50))
        labelautor.text = "Autor:"
        let autor = StyledTextField()
        autor.frame = CGRect(x: 10, y: 375, width: self.view.frame.width - 20, height: 40)
        self.view.addSubview(autor)
        self.view.addSubview(labelautor)
        
        labeltitol = UILabel(frame: CGRect(x:10,y:265,width:500,height:50))
        labeltitol.text = "Autor:"
        let titol = StyledTextField()
        titol.frame = CGRect(x: 10, y: 300, width: self.view.frame.width - 20, height: 40)
        self.view.addSubview(titol)
        self.view.addSubview(labeltitol)
        
        labelkeywords = UILabel(frame: CGRect(x:10,y:415,width:500,height:50))
        labelkeywords.text = "Keywords:"
        let keywords = StyledTextField()
        keywords.frame = CGRect(x: 10, y: 450, width: self.view.frame.width - 20, height: 40)
        self.view.addSubview(keywords)
        self.view.addSubview(labelkeywords)
        
        labeldate = UILabel(frame: CGRect(x:10,y:505,width:500,height:50))
        labeldate.text = "Fecha creación:"
        self.view.addSubview(labeldate)
        date = UIDatePicker(frame: CGRect(x:45,y:515,width:100,height:50))
        date.datePickerMode = .date
        self.view.addSubview(date)
        
        
        labelfilename = UILabel(frame: CGRect(x:10,y:545,width:500,height:50))
        labelfilename.text = "Filename:"
        let filename = StyledTextField()
        filename.frame = CGRect(x: 10, y: 580, width: self.view.frame.width - 20, height: 40)
        self.view.addSubview(filename)
        self.view.addSubview(labelfilename)
        
        
        button = UIButton(frame: CGRect(x:150,y:750,width:100,height:50))
        button.setTitle("REGISTRA", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(ClickedButton), for: .touchUpInside)
        view.addSubview(button)
        
        imgpick = UIButton(frame: CGRect(x:150,y:630,width:100,height:50))
        imgpick.setTitle("GET IMAGE", for: .normal)
        imgpick.setTitleColor(.blue, for: .normal)
        imgpick.addTarget(self, action: #selector(ClickedButtonImg), for: .touchUpInside)
        let imgpicktf = StyledTextField()
        imgpicktf.frame = CGRect(x: 150, y: 635, width: 100, height: 40)
        self.view.addSubview(imgpicktf)
        self.view.addSubview(imgpick)
          
    }
    
    @objc func ClickedButton(){
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func ClickedButtonImg(){

        ImagePickerManager().pickImage(self){ image in
        }
    }
}
