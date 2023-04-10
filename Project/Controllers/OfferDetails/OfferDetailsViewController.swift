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
        descriptionLabel.numberOfLines = 0
        
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
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    
    
    // MARK: -> Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.setupTexts()
        self.setUpView()
   
    }
    
    
    // MARK: -> Setting Up View
    
    private func setUpView() {
        
        let margins = view.layoutMarginsGuide
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])

        addingSubViews()
    }
    

    
    private func addingSubViews() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(seniorityLabel)
        stackView.addArrangedSubview(modalityLabel)
        stackView.addArrangedSubview(remoteModality)
        stackView.addArrangedSubview(companyLogo)
        stackView.addArrangedSubview(companyName)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(buttonLink)
    }
    
    private func setupTexts() {
        
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
              
    }
    
    
    @objc private func didTapButton() {
        guard let url = URL(string: "\(String(describing: self.jobInfo?.publicUrl ?? "https://google.com"))") else {
            print("link: \(String(describing: self.jobInfo?.publicUrl))")
            return
        }
        
        let vc = WebViewViewController(url: url, title: "\(String(describing: self.jobInfo?.publicUrl ?? "https://google.com"))")
        
        
        // These lines below throw a Security Error, It's supposed to be an Apple Bug
        let navVC = UINavigationController(rootViewController: vc)
        DispatchQueue.main.async {
            self.present(navVC, animated: true)
        }
 
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
