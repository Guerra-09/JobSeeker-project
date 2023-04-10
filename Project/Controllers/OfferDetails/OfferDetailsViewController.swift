//
//  OfferDetailsViewController.swift
//  Project
//
//  Created by José Guerra on 27-03-23.
//

import Foundation
import UIKit
import WebKit

class OfferDetailsViewController: UIViewController {
    
    var jobInfo: JobOfferModel?
    
    // MARK: -> Components
    
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var seniorityLabel: UILabel = {
        let seniorityLabel = UILabel()
        seniorityLabel.translatesAutoresizingMaskIntoConstraints = false
        return seniorityLabel
    }()
    
    private var modalityLabel: UILabel = {
        let modality = UILabel()
        modality.numberOfLines = 2
        modality.translatesAutoresizingMaskIntoConstraints = false
        return modality
    }()
    
    private var remoteModality: UILabel = {
        let remote = UILabel()
        remote.translatesAutoresizingMaskIntoConstraints = false
        return remote
    }()
    
    private var descriptionLabel: UILabel = {
       let descriptionLabel = UILabel()
        descriptionLabel.text = "description placeholder"
        descriptionLabel.numberOfLines = 15
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private var companyLogo: UIImageView = {
        let imageView = UIImageView() // 1
        
        imageView.image = UIImage(systemName: "photo") // 2
        imageView.translatesAutoresizingMaskIntoConstraints = false // 3
        return imageView
    }()
    
    private var companyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var buttonLink: UIButton = {
        var btn = UIButton.Configuration.filled()
        btn.title = "Ver Anuncio"
        let button = UIButton(type: .system)
        button.configuration = btn
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(OfferDetailsViewController.self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    private let scrollView = UIScrollView()
    
    
    
    
    // MARK: -> Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.setupUI()
        //view.addSubview(scrollView)

//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//        ])
   
    }
    
    
    // MARK: -> Setting Up View

    
    private func setupUI() {
        
  
        self.view.addSubview(titleLabel)
        self.view.addSubview(seniorityLabel)
        self.view.addSubview(modalityLabel)
        self.view.addSubview(remoteModality)
        self.view.addSubview(companyLogo)
        self.view.addSubview(companyName)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(buttonLink)
    
        
        // Setting up Title label
        titleLabel.text = self.jobInfo?.title
        if let titleLenght = self.jobInfo?.title.count {
            titleLabel.font = titleLenght < 22 ? UIFont(name: "HelveticaNeue-Bold", size: 30.0) : UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        }

        
        
        // Settingup seniority Label
        if self.jobInfo?.seniority.id == 1 {
            seniorityLabel.text = "Seniority: Sin Experiencia"
            
        } else if self.jobInfo?.seniority.id == 2 {
            seniorityLabel.text = "Seniority: Junior"
            
        } else if self.jobInfo?.seniority.id == 3 {
            seniorityLabel.text = "Seniority: Semi Senior"
            
        } else if self.jobInfo?.seniority.id == 4 {
            seniorityLabel.text = "Seniority: Senior"
            
        } else if self.jobInfo?.seniority.id == 5 {
            seniorityLabel.text = "Seniority: Expert"
            
        } else {
            seniorityLabel.text = "Seniority: not specified"
        }
        
        
        // Setting up company logo and name
        companyName.text = self.jobInfo?.company.name
        if let logoUrl = self.jobInfo?.company.logo  {
            companyLogo.load(urlRequest: logoUrl)
        } else {
            companyLogo.image = UIImage(systemName: "photo")
        }
        
        
        // Setting up type of job
        var modalityPlaceholder = ""
        if self.jobInfo?.modality.id == 1 {
            modalityPlaceholder = "Full Time"
            
        } else if self.jobInfo?.modality.id == 2 {
            modalityPlaceholder = "Part Time"
            
        } else if self.jobInfo?.modality.id == 3 {
            modalityPlaceholder = "Freelance"
            
        }else if self.jobInfo?.modality.id == 4 {
            modalityPlaceholder = "Práctica/Internship"
            
        } else {
            modalityPlaceholder = "No especificado"
        }
        modalityLabel.text = "Tipo: \(modalityPlaceholder)"
        
        
        
        // Setting up modality remote
        if self.jobInfo?.remoteModality == "no_remote" {
            remoteModality.text = "Modalidad: No remoto"
            
        } else if self.jobInfo?.remoteModality == "temporarily_remote" {
            remoteModality.text = "Modalidad: Temporalmente remoto"
            
        } else if self.jobInfo?.remoteModality == "remote_local" {
            remoteModality.text = "Modalidad: Temporalmente remoto"
            
        } else if self.jobInfo?.remoteModality == "fully_remote" {
            remoteModality.text = "Modalidad: Remoto"
            
        } else if self.jobInfo?.remoteModality == "hybrid" {
            remoteModality.text = "Modalidad: Hibrido"
            
        }else {
            remoteModality.text = "Modalidad: Caso extranio"
            print(self.jobInfo?.remoteModality ?? "Error")
            
            
        }
    
        
        // Setting up requirements of the job
        descriptionLabel.text = "Requerimientos del cargo:\n\(self.jobInfo?.description.htmlToString ?? "null")"
        
        NSLayoutConstraint.activate([
    
            //Setting up Offer Name constraints
            titleLabel.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: seniorityLabel.topAnchor),
            
            // Setting up seniority constraints
            seniorityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            seniorityLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            seniorityLabel.bottomAnchor.constraint(equalTo: modalityLabel.topAnchor),
            
            
            modalityLabel.topAnchor.constraint(equalTo: seniorityLabel.bottomAnchor),
            modalityLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            modalityLabel.bottomAnchor.constraint(equalTo: remoteModality.topAnchor),
            
            remoteModality.topAnchor.constraint(equalTo: modalityLabel.bottomAnchor),
            remoteModality.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            remoteModality.bottomAnchor.constraint(equalTo: companyLogo.topAnchor),
            
            // Setting up company logo
            companyLogo.topAnchor.constraint(equalTo: remoteModality.bottomAnchor),
            companyLogo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            companyLogo.bottomAnchor.constraint(equalTo: companyName.topAnchor),
            
            
            // Setting up company name
            companyName.topAnchor.constraint(equalTo: companyLogo.bottomAnchor),
            companyName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            companyName.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: companyName.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: buttonLink.topAnchor),
            
            buttonLink.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            buttonLink.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonLink.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -50),

            
            
            
        ])
    }
    
    
    @objc private func didTapButton() {
        guard let url = URL(string: "\(String(describing: self.jobInfo?.publicUrl ?? "https://google.com"))") else {
            print("link: \(String(describing: self.jobInfo?.publicUrl))")
            return
        }
        
        let vc = WebViewViewController(url: url, title: "\(String(describing: self.jobInfo?.publicUrl ?? "https://google.com"))")
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
        

        
    }
    
}


extension UIImageView {
    
    func load(urlRequest: String) {
        
        if let url = URL(string: urlRequest) {
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
            
        } else {
            print("nil value")
        }

    }
}



extension String {
    func paragraphs(withLineLength lineLength: Int) -> String {
        var result = ""
        var currentLine = ""
        let words = self.split(separator: " ", omittingEmptySubsequences: false)
        for word in words {
            let wordWithSpace = word + " "
            if currentLine.count + wordWithSpace.count <= lineLength {
                currentLine += wordWithSpace
            } else {
                result += currentLine + "\n"
                currentLine = String(wordWithSpace)
            }
        }
        result += currentLine
        return result
    }
}
