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
    
    
    private let items: [String]
    private let img: UIImage
    
    init(items: Category2){
        self.img = items.img
        self.items = items.items2
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
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(items[indexPath.row])
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
