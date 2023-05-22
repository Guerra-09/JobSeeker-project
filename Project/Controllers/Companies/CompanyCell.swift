//
//  CategoryCell.swift
//  Project
//
//  Created by José Guerra on 15-03-23.
//

import UIKit
import Kingfisher

class CompanyCell: UITableViewCell {

    static let identifier = "CompanyCell"
    
    private let companyCellLabel: UILabel = {
        let name = UILabel()
        name.text = " "
        name.textColor = .label
        name.textAlignment = .left
        name.font = .systemFont(ofSize: 18, weight: .medium)
        return name
    }()
    
    private var companyCellLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no implementado")
    }
    
    
    public func configure(url image: String, and label: String) {
        
        if image == "" {
            self.companyCellLogo.image = UIImage(systemName: "photo")
        } else {
            self.companyCellLogo.kf.setImage(with: URL(string: image))
        }
        
        self.companyCellLabel.text = label
    }
    
    private func setupUI() {
        self.contentView.addSubview(companyCellLabel)
        self.contentView.addSubview(companyCellLogo)
        
        companyCellLabel.translatesAutoresizingMaskIntoConstraints = false
        companyCellLogo.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
        
            companyCellLogo.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            
            companyCellLogo.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            
            companyCellLogo.trailingAnchor.constraint(equalTo: companyCellLabel.leadingAnchor),
            
            companyCellLogo.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            
            companyCellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            companyCellLabel.leadingAnchor.constraint(equalTo: companyCellLogo.trailingAnchor)
            
            
            
        ])
        
        
    }
}


extension UIImage {

func resize(targetSize: CGSize) -> UIImage {
    return UIGraphicsImageRenderer(size:targetSize).image { _ in
        self.draw(in: CGRect(origin: .zero, size: targetSize))
    }
}

}
