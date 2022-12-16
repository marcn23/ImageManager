
//
//  DeleteViewController.swift
//  ImageManager
//
//  Created by albert on 15/12/22.
//

import Foundation
import UIKit

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?;
    override init(){
        super.init()
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }

        // Add the actions
        picker.delegate = self
       // alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;

        alert.popoverPresentationController?.sourceView = self.viewController!.view

        viewController.present(alert, animated: true, completion: nil)
    }

    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        pickImageCallback?(image)
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }
}


class StyledTextField: UITextField{
    override init(frame: CGRect){
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.rightViewMode = .always
        self.clearButtonMode = .whileEditing
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ModifyViewController: UIViewController {

    //Variables containing the info:
    var imgId: String!
    var imgTitle: String!
    var imgDescription: String!
    var imgKeywords: String!
    var imgCreator: String!
    var imgAuthor: String!
    var imgFilename: String!
    var imgDate: String!
    
    
    var label: UILabel!
    var button: UIButton!
    
    var imgpick: UIButton!
    var imgpicktf = StyledTextField()
    
    var autor = StyledTextField()
    var labelautor:UILabel!
    
    var titol = StyledTextField()
    var labeltitol:UILabel!
    
    var desc = StyledTextField()
    var labeldesc:UILabel!
    
    var keywords = StyledTextField()
    var labelkeywords:UILabel!
    
    var labeldate:UILabel!
    var labelbutton:UILabel!
    var date: UIDatePicker!
  
    var filename = StyledTextField()
    var labelfilename:UILabel!
    
    var imageSelected: UIImage!
    
    override func viewDidLoad(){
        Task {
            super.viewDidLoad()
            
            self.view.backgroundColor = UIColor(red: 0.0, green: 0.35, blue: 0.4, alpha: 1)

            label = UILabel(frame: CGRect(x:60,y:75,width:500,height:50))
            label.text = "MODIFICAR IMAGEN"
            label.font = label.font.withSize(30)
            label.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            view.addSubview(label)
            
            labelautor = UILabel(frame: CGRect(x:10,y:240,width:500,height:50))
            labelautor.text = "Autor:"
            labelautor.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            //let autor = StyledTextField()
            autor.frame = CGRect(x: 10, y: 275, width: self.view.frame.width - 20, height: 40)
            autor.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            autor.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
            autor.text = imgAuthor
            self.view.addSubview(autor)
            self.view.addSubview(labelautor)
            
            labeltitol = UILabel(frame: CGRect(x:10,y:165,width:500,height:50))
            labeltitol.text = "Titol:"
            labeltitol.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            //let titol = StyledTextField()
            titol.frame = CGRect(x: 10, y: 200, width: self.view.frame.width - 20, height: 40)
            titol.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            titol.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
            titol.text = imgTitle
            self.view.addSubview(titol)
            self.view.addSubview(labeltitol)
            
            labeldesc = UILabel(frame: CGRect(x:10,y:525,width:500,height:50))
            labeldesc.text = "Descripción:"
            labeldesc.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            //let desc = StyledTextField()
            desc.frame = CGRect(x: 10, y: 360, width: self.view.frame.width - 20, height: 40)
            desc.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            desc.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
            desc.text = imgDescription
            self.view.addSubview(desc)
            self.view.addSubview(labeldesc)
            
            labelkeywords = UILabel(frame: CGRect(x:10,y:315,width:500,height:50))
            labelkeywords.text = "Keywords:"
            labelkeywords.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            //let keywords = StyledTextField()
            keywords.frame = CGRect(x: 10, y: 550, width: self.view.frame.width - 20, height: 40)
            keywords.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            keywords.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
            keywords.text = imgKeywords
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
            
            /*
            labelfilename = UILabel(frame: CGRect(x:10,y:445,width:500,height:50))
            labelfilename.text = "Nombre archivo:"
            labelfilename.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            //let filename = StyledTextField()
            filename.frame = CGRect(x: 10, y: 480, width: self.view.frame.width - 20, height: 40)
            filename.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            filename.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
            filename.text = imgFilename
            self.view.addSubview(filename)
            self.view.addSubview(labelfilename)*/
            
            
            button = UIButton(frame: CGRect(x:150,y:750,width:110,height:50))
            button.setTitle("MODIFICA", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(executeModification), for: .touchUpInside)

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
            //let imgpicktf = StyledTextField()
            imgpicktf.frame = CGRect(x: 155, y: 680, width: 100, height: 40)
            imgpicktf.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            imgpicktf.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
            self.view.addSubview(imgpicktf)
            self.view.addSubview(imgpick)
            print(imgId, " ", imgTitle, " ", imgAuthor, " ", imgCreator, " ", imgFilename, " ", imgDescription, " ", imgKeywords)
        }
    }
    
    @objc func executeModification(){
        Task{
            let newtit = titol.text!
            let newdesc = desc.text!
            let newaut = autor.text!
            let newkey = keywords.text!
            let newfilen = filename.text!
            
            var modified = "true"
            //print(imageSelected.size)
            if imageSelected == nil {
                print("ok")
                modified = "false"
                imageSelected = nil
            }
            
            print(imgId + " " + newtit + " " + newaut + " " + newkey + " "  + newdesc + " " +  newfilen)
            
            await ImageManager().modifyImage(id: imgId, title: newtit, description: newdesc, keywords: newkey, author: newaut, creator: newaut, capture: imgDate, oldFilename: imgFilename, filename: imgFilename, modified: modified, img: imageSelected)
            
            let vc = ViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func ClickedButtonImg(){
        ImagePickerManager().pickImage(self){ image in
            self.imageSelected = image
            print(self.imageSelected.size)
        }
    }
}
