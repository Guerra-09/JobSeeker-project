//
//  JobOffersModel.swift
//  Project
//
//  Created by José Guerra on 23-03-23.
//

import Foundation

struct JobOfferHandler: Codable {
    let data: [JobOfferModel]
    
}

struct OfferCompanyModel: Codable {
    let data: String = ""
    let attributes: String = ""
    
    let name: String
    let logo: String
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case attributes = "attributes"
        
        case name = "name"
        case logo = "logo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        let attributes = try data.nestedContainer(keyedBy: CodingKeys.self, forKey: .attributes)
        self.name = try attributes.decode(String.self, forKey: .name)
        self.logo = try attributes.decode(String.self, forKey: .logo)
        
    }
}

struct SeniorityModel: Codable {
    
    let data: String = ""
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        self.id = try data.decode(Int.self, forKey: .id)
        
    }

}

struct Modality: Codable {
    let data: String = ""
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.id = try data.decode(Int.self, forKey: .id)
    }
    
}

struct JobOfferModel: Codable {
    
    let id: String
    let attributes: String = ""
    
    // Inside of attributes
    let title: String
    let descriptionHeadline: String
    let description: String
    let remote: Bool
    let remoteModality: String
        
    let seniority: SeniorityModel
    let company: OfferCompanyModel
    let modality: Modality
    
    let links: String = ""
    let publicUrl: String
    
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case links = "links"
        case publicUrl = "public_url"
        
        case attributes = "attributes"
        
        case title = "title"
        case descriptionHeadline = "description_headline"
        case description = "description"
        case remote = "remote"
        case remoteModality = "remote_modality"
        
        case seniority = "seniority"
        case company = "company"
        case modality = "modality"
        
    
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        
        let attributes = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .attributes)
        self.title = try attributes.decode(String.self, forKey: .title)
        self.descriptionHeadline = try attributes.decode(String.self, forKey: .descriptionHeadline)
        self.description = try attributes.decode(String.self, forKey: .description)
        self.remote = try attributes.decode(Bool.self, forKey: .remote)
        self.remoteModality = try attributes.decode(String.self, forKey: .remoteModality)
        
        self.seniority = try attributes.decode(SeniorityModel.self, forKey: .seniority)
        self.company = try attributes.decode(OfferCompanyModel.self, forKey: .company)
        self.modality = try attributes.decode(Modality.self, forKey: .modality)
        
        let links = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .links)
        self.publicUrl = try links.decode(String.self, forKey: .publicUrl)
    }
    
    
}
