//
//  CategoryCell.swift
//  Project
//
//  Created by José Guerra on 15-03-23.
//

import UIKit

class CategoryCell: UITableViewCell {

    static let identifier = "CategoryCell"
    
    private let categoryNameLabel: UILabel = {
       
        let name = UILabel()
        name.text = " "
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
            categoryNameLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            categoryNameLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            categoryNameLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor)
            
        ])
        
        
    }
}
