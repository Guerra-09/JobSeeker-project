//
//  CategoryCell.swift
//  Project
//
//  Created by José Guerra on 15-03-23.
//

import UIKit

class CompanyCell: UITableViewCell {

    static let identifier = "CompanyCell"
    
    private let companyCellLabel: UILabel = {
       
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
        self.contentView.addSubview(companyCellLabel)
        
        companyCellLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            companyCellLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            companyCellLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            companyCellLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            companyCellLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor)
            
        ])
        
        
    }
}
