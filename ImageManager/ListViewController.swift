//
//  ListViewController.swift
//  TableViewPassData
//
//  Created by albert on 14/12/22.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    private var items: [String]
    private var imageTitle: String
    private let img: UIImage
    
    init(items: Category2){
        self.img = items.img
        self.items = items.items2
        self.imageTitle = items.t
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder){
        fatalError("F")
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional set
    }
    
    override func viewDidLoad() {
        Task{
            super.viewDidLoad()
            /*print(items[0])
            var imageData = await ImageManager().downloadImg(idImg: items[0])
            let imageView = UIImageView()
            imageView.frame = self.view.frame
            imageView.contentMode = .scaleAspectFit
            imageView.image = imageData
            imageView.center = CGPoint(x: 160, y: 300)
            self.view.addSubview(imageView)
            print(imageData)*/
            view.backgroundColor = .systemBackground
            view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            //tableView.rowHeight = 100.0
            self.tableView.backgroundColor = UIColor(red: 0.0, green: 0.35, blue: 0.4, alpha: 1)

            items.append("")
            items.append("MODIFICA")
            items.append("ELIMINA")
        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row == 0 {
            cell.imageView?.image = img
            cell.imageView?.center = self.tableView.center
        }
        else {
            cell.textLabel?.text = items[indexPath.row]
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            
            if (indexPath.row == 7 || indexPath.row == 8) {
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
            }
        }
        cell.backgroundColor = UIColor(red: 0.22, green: 0.55, blue: 0.60, alpha: 1)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(items[indexPath.row])
        print(indexPath.row)
        
        //MODIFICA
        if indexPath.row == 8 {
            let vc = ModifyViewController()
            vc.imgId = items[0]
            vc.imgTitle = imageTitle
            vc.imgKeywords = items[2]
            vc.imgDescription = items[1]
            vc.imgCreator = items[4]
            vc.imgAuthor = items[3]
            vc.imgDate = items[5]
            vc.imgFilename = items[6]
            
            //Cleaning content:
            
            vc.imgKeywords = vc.imgKeywords.replacingOccurrences(of: "Keywords: ", with: "")
            vc.imgDescription = vc.imgDescription.replacingOccurrences(of: "Description: ", with: "")
            vc.imgAuthor = vc.imgAuthor.replacingOccurrences(of: "Autor: ", with: "")
            vc.imgFilename = vc.imgFilename.replacingOccurrences(of: "Filename: ", with: "")
            vc.imgDate = vc.imgDate.replacingOccurrences(of: "Data: ", with: "")
            vc.imgCreator = vc.imgCreator.replacingOccurrences(of: "Creador: ", with: "")

            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        //ELIMINA
        if indexPath.row == 9 {
            Task {
                let imgMan = ImageManager()
                var i = items[0]
                var c = items[4]
                c = c.replacingOccurrences(of: "Creador: ", with: "")
                print(c)
                await imgMan.deleteImage(id: i, creator: c)
            
                let vc = DeleteViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200.0
        }
        else {
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200.0
        }
        else {
            return UITableView.automaticDimension
        }
    }
}

extension UIImage {
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)
            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }
}
