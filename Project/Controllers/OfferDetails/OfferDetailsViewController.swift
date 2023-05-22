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
        descriptionLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 1000)
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
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 13.5)
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
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    
    
    
    // MARK: -> Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")

        self.setUpView()
   
    }
    
    
    // MARK: -> Setting Up View
    
    private func setUpView() {
        
        let margins = view.layoutMarginsGuide
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
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
        
        self.setUpLabelTitle()
        self.setUpCompanyName()
        self.setUpSeniorityLevel()
        self.setUpCompanyLogo()
        self.setUpJobType(modalityId: self.jobInfo?.modality.id ?? 0)
        self.setUpRemoteModality(modalidad: "\(self.jobInfo?.remoteModality ?? "")")
        self.setUpDescription()
        
        
    }
    
    func setUpCompanyName() {
        companyName.text = self.jobInfo?.company.name
              
    }
    
    func setUpLabelTitle() {
        // Setting up Title label
        titleLabel.text = self.jobInfo?.title
        if let titleLenght = self.jobInfo?.title.count {
            titleLabel.font = titleLenght < 22 ? UIFont(name: "HelveticaNeue-Bold", size: 30.0) : UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        }
    }
    
    func setUpSeniorityLevel() {

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
    }
    
    
    func setUpJobType(modalityId: Int) -> String {
        // Setting up type of job
        var modalityPlaceholder = ""
        
        if modalityId == 1 {
            modalityPlaceholder = "Full Time"
            
        } else if modalityId == 2 {
            modalityPlaceholder = "Part Time"
            
        } else if modalityId == 3 {
            modalityPlaceholder = "Freelance"
            
        }else if modalityId == 4 {
            modalityPlaceholder = "Práctica/Internship"
            
        } else {
            modalityPlaceholder = "No especificado"
        }
        modalityLabel.text = "Tipo: \(modalityPlaceholder)"
        
        return modalityPlaceholder
    }
    
    
    
    func setUpRemoteModality(modalidad: String) -> String {
        // Setting up modality remote
        if modalidad == "no_remote" {
            remoteModality.text = "Modalidad: No remoto"
            return "Modalidad: No remoto"
            
        } else if modalidad == "temporarily_remote" {
            remoteModality.text = "Modalidad: Temporalmente remoto"
            return "Modalidad: Temporalmente remoto"
            
        } else if modalidad == "remote_local" {
            remoteModality.text = "Modalidad: Temporalmente remoto"
            return "Modalidad: Temporalmente remoto"
            
        } else if modalidad == "fully_remote" {
            remoteModality.text = "Modalidad: Remoto"
            return "Modalidad: Remoto"
            
        } else if modalidad == "hybrid" {
            remoteModality.text = "Modalidad: Hibrido"
            return "Modalidad: Hibrido"
            
        }else {
            remoteModality.text = "Modalidad: Caso extranio"
            print(self.jobInfo?.remoteModality ?? "Error")
            return modalidad
        }
        
    }
    
    func setUpCompanyLogo() {
        
        if let logoUrl = self.jobInfo?.company.logo  {
            companyLogo.load(urlRequest: logoUrl)
        } else {
            companyLogo.image = UIImage(systemName: "photo")
        }
    }
    
    func setUpDescription() {
        // Setting up requirements of the job
        descriptionLabel.text = "Requerimientos del cargo:\n\n\(self.jobInfo?.description.htmlToString ?? "null")"
        
        print("sin conversion: \(self.jobInfo?.description)\n con: \(self.jobInfo?.description.htmlToString)")
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

