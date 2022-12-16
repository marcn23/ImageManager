
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
    
    var desc: UITextField!
    var labeldesc:UILabel!
    
    var titol: UITextField!
    var labeltitol:UILabel!
    
    var keywords: UITextField!
    var labelkeywords:UILabel!
    
    var labeldate:UILabel!
    var labelbutton:UILabel!
    var date: UIDatePicker!
  
    var filename: UITextField!
    var labelfilename:UILabel!
    
    var imatgepick: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.0, green: 0.35, blue: 0.4, alpha: 1)

        label = UILabel(frame: CGRect(x:60,y:75,width:500,height:50))
        label.text = "REGISTRAR IMAGEN"
        label.font = label.font.withSize(30)
        label.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        view.addSubview(label)
        
        labelautor = UILabel(frame: CGRect(x:10,y:240,width:500,height:50))
        labelautor.text = "Autor:"
        labelautor.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        let autor = StyledTextField()
        autor.frame = CGRect(x: 10, y: 275, width: self.view.frame.width - 20, height: 40)
        autor.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        autor.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        self.view.addSubview(autor)
        self.view.addSubview(labelautor)
        
        labeltitol = UILabel(frame: CGRect(x:10,y:165,width:500,height:50))
        labeltitol.text = "Titol:"
        labeltitol.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        let titol = StyledTextField()
        titol.frame = CGRect(x: 10, y: 200, width: self.view.frame.width - 20, height: 40)
        titol.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        titol.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        self.view.addSubview(titol)
        self.view.addSubview(labeltitol)
        
        labelkeywords = UILabel(frame: CGRect(x:10,y:315,width:500,height:50))
        labelkeywords.text = "Keywords:"
        labelkeywords.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        let keywords = StyledTextField()
        keywords.frame = CGRect(x: 10, y: 350, width: self.view.frame.width - 20, height: 40)
        keywords.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        keywords.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        self.view.addSubview(keywords)
        self.view.addSubview(labelkeywords)
        
        labeldate = UILabel(frame: CGRect(x:10,y:405,width:500,height:50))
        labeldate.text = "Fecha creación:"
        labeldate.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        self.view.addSubview(labeldate)
        date = UIDatePicker(frame: CGRect(x:45,y:415,width:100,height:50))
        date.datePickerMode = .date
        //date.backgroundColor = UIColor.white
        //date.setValue(UIColor.white, forKey: "textColor")
        self.view.addSubview(date)
        
        
        labelfilename = UILabel(frame: CGRect(x:10,y:445,width:500,height:50))
        labelfilename.text = "Nombre archivo:"
        labelfilename.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        let filename = StyledTextField()
        filename.frame = CGRect(x: 10, y: 480, width: self.view.frame.width - 20, height: 40)
        filename.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        filename.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        self.view.addSubview(filename)
        self.view.addSubview(labelfilename)
        
        labeldesc = UILabel(frame: CGRect(x:10,y:525,width:500,height:50))
        labeldesc.text = "Descripción:"
        labeldesc.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        let desc = StyledTextField()
        desc.frame = CGRect(x: 10, y: 560, width: self.view.frame.width - 20, height: 40)
        desc.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        desc.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        self.view.addSubview(desc)
        self.view.addSubview(labeldesc)
        
        button = UIButton(frame: CGRect(x:150,y:750,width:110,height:50))
        button.setTitle("REGISTRA", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(ClickedButton), for: .touchUpInside)

        let labelbutton = StyledTextField()
        labelbutton.frame = CGRect(x: 150, y: 755, width: 110, height: 40)
        labelbutton.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        labelbutton.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        self.view.addSubview(labelbutton)
        view.addSubview(button)
        
        imgpick = UIButton(frame: CGRect(x:155,y:675,width:100,height:50))
        imgpick.setTitle("GET IMAGE", for: .normal)
        imgpick.setTitleColor(.black, for: .normal)
        imgpick.addTarget(self, action: #selector(ClickedButtonImg), for: .touchUpInside)
        let imgpicktf = StyledTextField()
        imgpicktf.frame = CGRect(x: 155, y: 680, width: 100, height: 40)
        imgpicktf.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        imgpicktf.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
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
