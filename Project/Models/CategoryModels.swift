//
//  CategoryModel.swift
//  Project
//
//  Created by José Guerra on 15-03-23.
//

import Foundation

struct ModelHandler: Codable {
    
    let data: [CategoryModel]
}

struct CategoryModel: Codable {
    
    let id: String
    let type: String
    let attributes: String = ""
    let name: String
    let dimension: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case attributes = "attributes"
        case name = "name"
        case dimension = "dimension"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(String.self, forKey: .type)
        
        let attributes = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .attributes)
        
        self.name = try attributes.decode(String.self, forKey: .name)
        self.dimension = try attributes.decode(String.self, forKey: .dimension)
        
    }
    
}
