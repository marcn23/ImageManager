//
//  SwiftBetaCustomCell.swift
//  projectTEST
//
//  Created by albert on 4/12/22.
//

import UIKit

class SwiftBetaCustomCell: UITableViewCell {
    
    private let deviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let deviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize:24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //addSubview(deviceImageView)
        addSubview(deviceNameLabel)
        
        NSLayoutConstraint.activate([
            deviceImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            deviceImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            deviceImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            deviceImageView.widthAnchor.constraint(equalToConstant: 40),
            deviceImageView.heightAnchor.constraint(equalToConstant: 40),
            
            //deviceNameLabel.leadingAnchor.constraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: 20),
            
            //deviceNameLabel.centerYAnchor.constraint(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Device){
        deviceImageView.image = UIImage(systemName: model.imageName)
        deviceNameLabel.text = model.title
    }


}
