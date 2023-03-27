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

struct JobOfferModel: Codable {
    
    let id: String
    let type: String
    let attributes: String = ""
    
    // Inside of attributes
    let title: String
    let descriptionHeadline: String
    let description: String

    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case type = "type"
        case attributes = "attributes"
        
        case title = "title"
        case descriptionHeadline = "description_headline"
        case description = "description"
    
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(String.self, forKey: .type)
        
        let attributes = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .attributes)
        self.title = try attributes.decode(String.self, forKey: .title)
        self.descriptionHeadline = try attributes.decode(String.self, forKey: .descriptionHeadline)
        self.description = try attributes.decode(String.self, forKey: .description)

    }
    
    
}
