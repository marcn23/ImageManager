//
//  ViewController.swift
//  projectTEST
//
//  Created by albert on 4/12/22.
//

import UIKit

struct Device{
    let title: String
    let imageName: String
}

let house = [
    Device(title: "Laptop", imageName: "laptopcomputer"),
    Device(title: "Mac mini", imageName: "macmini"),
    Device(title: "Mac Pro", imageName: "macpro.gen3"),
    Device(title: "Pantallas", imageName: "display.2"),
    Device(title: "Apple TV", imageName: "appletv"),
]

var imatges = [String]()

class ViewController: UIViewController, UITableViewDataSource {

    var result = Book()
    
    private let deviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad(){
        var n = 0
        //let group = DispatchGroup()
        //group.enter()
        let sem = DispatchSemaphore(value: 1)
        Task{
            //group.enter()
            n = n+1
            result = await ImageManager().getImages()
            let imgNumber  = result.imageNumber
            for (key, value) in result.Images{
                imatges.append(value.ttl)
            }
            print("In: ", n)
            sem.signal()
            //print("Number: ", imgNumber)
            //group.leave()
            //group.notify(queue: .main){
               //print("End")
            //}
            //sem.wait()
            //group.wait()
            //group.leave()
            print("Out:", n)
            print(imatges)
            print(result.imageNumber)
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            deviesTableView.backgroundColor = .blue
            deviesTableView.dataSource = self
            deviesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
            //deviesTableView.register(SwiftBetaCustomCell.self, forCellReuseIdentifier: "SwiftBetaCustomCell")
            view.addSubview(deviesTableView)
            
            NSLayoutConstraint.activate([
                deviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                deviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                deviesTableView.topAnchor.constraint(equalTo: view.topAnchor),
                deviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imatges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let model = imatges[indexPath.row]
        
        var listContentConfiguration = UIListContentConfiguration.cell()
        listContentConfiguration.text = model
        
        cell.contentConfiguration = listContentConfiguration
        
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
 
