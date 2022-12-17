//
//  ViewController.swift
//  projectTEST
//
//  Created by albert on 4/12/22.
//

import UIKit

struct Category{
    let title: String
    let items: [String]
}

struct Category2{
    let t: String
    let items2: [String]
    let img: UIImage
    //let image: UIImage
}

class ViewController: UIViewController {
    
    var result = Book()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var data2 = [Category2]()
    
    private let data: [Category] = [
        Category(title: "Fruits", items: ["Appple", "Orange", "Banana"]),
        Category(title: "Cars", items: ["BMW", "Mercedes", "Audi"]),
        Category(title: "Cities", items: ["Barcelona", "Madrid", "Sevilla"])
    ]
    
    
    override func viewDidLoad(){
        //super.viewDidLoad()
        /*Task{
            result = await ImageManager().getImages()
            print(result.imageNumber)
            for(_, value) in result.Images{
                self.imageView.image = await ImageManager().downloadImg(idImg: value.id)
            }
        }
        Task{
            //group.enter()
            result = await ImageManager().getImages()
            for ( _ , value) in result.Images{
                imatges.append(value.ttl)
            }
            print(imatges)
            print(result.imageNumber)
            super.viewDidLoad()
            // Do any additional setup after loading the view.

        }*/
        Task{
            let imgMan = ImageManager()
            result = await imgMan.getImages()
            super.viewDidLoad()
            view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            /*var imageData: UIImage
            var imagesCollection = [UIImage]()
            for(key, value) in result.Images {
                imageData = await imgMan.downloadImg(idImg: key)
                imagesCollection.append(imageData)
            }*/
            for (key,value) in result.Images {
                var ArrayItems = [String]()
                ArrayItems.append(key)
                ArrayItems.append("Description: " + value.desc)
                ArrayItems.append("Keywords: " + value.keyw)
                ArrayItems.append("Autor: " + value.auth)
                ArrayItems.append("Creador: " + value.creat)
                ArrayItems.append("Data: " + value.dateC)
                ArrayItems.append("Filename: " + value.filen)
                print(value.imageData)
                let x = Category2(t: value.ttl, items2: ArrayItems, img: value.imageData)
                data2.append(x)
            }
            //var img = await ImageManager().downloadImg(idImg: "1683")
            //print("Image found:  ", img.size)
            //await ImageManager().modifyImage(id: "1685", title: "MessiModified", description: "messiuuuu", keywords: "futbol", author: "Marc", creator: "Marc", capture: "2020-09-26", oldFilename: "2022-11-28", filename: "1685gpique.png", img: img)
            
            //await ImageManager().registerImage(title: "Marc", description: "Marc", keywords: "Marc", author: "Marc", creator: "Marc", capture: "2022-12-17", filename: "Marc.png", img: img)
            super.viewDidLoad()
            self.tableView.backgroundColor = UIColor(red: 0.0, green: 0.35, blue: 0.4, alpha: 1)
            
            view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < data2.count{
            let category = data2[indexPath.row]
            let vc = ListViewController (items: category)
            vc.title = category.t
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == data2.count + 1{
            let vc2 = RegisterViewController()
            navigationController?.pushViewController(vc2, animated: true)
        }
    }
    
}
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data2.count + 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.row == data2.count {
            cell.textLabel?.text = ""
        }
        else if indexPath.row == data2.count + 1 {
            cell.textLabel?.text = "REGISTRAR NUEVA IMAGEN"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        }
        else {
            //var x = indexPath.row
            let num = String(indexPath.row)
            let display = (num + ". " + data2[indexPath.row].t)
            cell.textLabel?.text = display
        }
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        cell.backgroundColor = UIColor(red: 0.22, green: 0.55, blue: 0.60, alpha: 1)
        return cell
    }
}

/*
let urlM = URL(string: "https://683f-147-83-201-100.eu.ngrok.io/Practica4/resources/javaee8/getImage/606")

let dataTask = URLSession.shared.dataTask(with: urlM!){ data, response, error in
    if data != nil, error == nil {
        DispatchQueue.global().async {
            self.imageView.image = UIImage(data: data!)
            print("Data will be displayed")
        }
    }
}
dataTask.resume()
 */
 
