//
//  OfferCell.swift
//  Project
//
//  Created by José Guerra on 26-03-23.
//

import UIKit

class OfferCell: UITableViewCell {

    static let identifier = "OfferCell"
    
    private let categoryNameLabel: UILabel = {
       
        let name = UILabel()
        name.text = "a"
        name.textColor = .label
        name.textAlignment = .left
        name.font = .systemFont(ofSize: 24, weight: .medium)
        
        return name
        
    }()
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(cider:) no implementado")
    }
    
    private func setupUI() {
        self.contentView.addSubview(categoryNameLabel)
        
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            categoryNameLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            categoryNameLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            categoryNameLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            categoryNameLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
 
            
        ])
        
        
    }
}
