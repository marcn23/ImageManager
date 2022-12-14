//
//  ListViewController.swift
//  TableViewPassData
//
//  Created by albert on 14/12/22.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    private let imgView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    private let items: [String]
    
    init(items: [String]){
        self.items = items
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
            print(items[0])
            var imageData = await ImageManager().downloadImg(idImg: items[0])
            let imageView = UIImageView()
            imageView.frame = self.view.frame
            imageView.contentMode = .scaleAspectFit
            imageView.image = imageData
            imageView.center = CGPoint(x: 160, y: 300)
            self.view.addSubview(imageView)
            print(imageData)
            view.backgroundColor = .systemBackground
            //view.addSubview(tableView)
            //tableView.delegate = self
            //tableView.dataSource = self
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
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(items[indexPath.row])
    }

}
