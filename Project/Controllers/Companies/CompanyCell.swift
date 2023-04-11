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
    
    private var companyCellLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        //imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no implementado")
    }
    
    public func configure(with image: String, and label: String) {
        
        self.companyCellLogo.load(urlRequest: image)
        self.companyCellLabel.text = label
    }
    
    private func setupUI() {
        self.contentView.addSubview(companyCellLabel)
        self.contentView.addSubview(companyCellLogo)
        
        companyCellLabel.translatesAutoresizingMaskIntoConstraints = false
        companyCellLogo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            companyCellLogo.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            companyCellLogo.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            companyCellLogo.trailingAnchor.constraint(equalTo: companyCellLabel.leadingAnchor, constant: -15),
            companyCellLogo.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            companyCellLogo.heightAnchor.constraint(equalToConstant: 90),
            companyCellLogo.widthAnchor.constraint(equalToConstant: 90),
            
            companyCellLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            companyCellLabel.leadingAnchor.constraint(equalTo: companyCellLogo.trailingAnchor),
            companyCellLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            companyCellLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
        ])
        
        
    }
}
