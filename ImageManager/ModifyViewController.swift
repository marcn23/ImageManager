
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

    var label: UILabel!
    var button: UIButton!
    
    var imgpick: UIButton!
    var imgpicktf: UITextField!
    
    var autor: UITextField!
    var labelautor:UILabel!
    
    var keywords: UITextField!
    var labelkeywords:UILabel!
    
    var date: UIDatePicker!
  
    var filename: UITextField!
    var labelfilename:UILabel!
    
    var imatgepick: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        label = UILabel(frame: CGRect(x:70,y:175,width:500,height:50))
        label.text = "MODIFICAR IMAGEN"
        label.font = label.font.withSize(30)
        view.addSubview(label)
        
        labelautor = UILabel(frame: CGRect(x:10,y:265,width:500,height:50))
        labelautor.text = "Autor:"
        let autor = StyledTextField()
        autor.frame = CGRect(x: 10, y: 300, width: self.view.frame.width - 20, height: 40)
        self.view.addSubview(autor)
        self.view.addSubview(labelautor)
        
        
        labelkeywords = UILabel(frame: CGRect(x:10,y:340,width:500,height:50))
        labelkeywords.text = "Keywords:"
        let keywords = StyledTextField()
        keywords.frame = CGRect(x: 10, y: 375, width: self.view.frame.width - 20, height: 40)
        self.view.addSubview(keywords)
        self.view.addSubview(labelkeywords)
        
        
        date = UIDatePicker(frame: CGRect(x:40,y:450,width:100,height:50))
        date.datePickerMode = .date
        self.view.addSubview(date)
        
        
        labelfilename = UILabel(frame: CGRect(x:10,y:485,width:500,height:50))
        labelfilename.text = "Filename:"
        let filename = StyledTextField()
        filename.frame = CGRect(x: 10, y: 520, width: self.view.frame.width - 20, height: 40)
        self.view.addSubview(filename)
        self.view.addSubview(labelfilename)
        
        
        button = UIButton(frame: CGRect(x:150,y:650,width:100,height:50))
        button.setTitle("MODIFICA", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(ClickedButton), for: .touchUpInside)
        view.addSubview(button)
        
        imgpick = UIButton(frame: CGRect(x:150,y:575,width:100,height:50))
        imgpick.setTitle("GET IMAGE", for: .normal)
        imgpick.setTitleColor(.blue, for: .normal)
        imgpick.addTarget(self, action: #selector(ClickedButtonImg), for: .touchUpInside)
        let imgpicktf = StyledTextField()
        imgpicktf.frame = CGRect(x: 150, y: 580, width: 100, height: 40)
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
