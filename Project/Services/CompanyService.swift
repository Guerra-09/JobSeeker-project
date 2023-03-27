//
//  CompanyService.swift
//  Project
//
//  Created by José Guerra on 21-03-23.
//

import Foundation
import Alamofire

class CompanyService {
    
    //var companyDelegate: CompanyControllerProtocol?
    
    func fetchingAPIData(completionHandler: @escaping (CompanyHandler?, Error?) -> Void) {
        let url = "https://www.getonbrd.com/api/v0/companies?per_page=10&page=1"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            
            switch response.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode(CompanyHandler.self, from: data!)
                    //print("companyService \(jsondata)")
                    completionHandler(jsondata, nil)
                    
                } catch {
                    print(error.localizedDescription)
                    print(String(describing: error))
                    completionHandler(nil, error)
                }
            
            case .failure(let error):
                print(error.localizedDescription)
                print(String(describing: error))
                completionHandler(nil, error)
                
            }
        }
    }
    
    
}

struct CompanyHandler: Codable {
    let data: [CompanyModel]
    
    
}

struct CompanyModel: Codable {
    
    let id: String
    let type: String
    let attributes: String = ""
    
    // Inside of attributes
    let name: String
    let description: String
    //let projects: String?
    let web: String
    let country: String
    let logo: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case attributes = "attributes"
        case name = "name"
        case description = "description"
        //case projects = "projects"
        case web = "web"
        case country = "country"
        case logo = "logo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(String.self, forKey: .type)
        
        let attributes = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .attributes)
        self.name = try attributes.decode(String.self, forKey: .name)
        self.description = try attributes.decode(String.self, forKey: .description)
        //self.projects = try attributes.decode(String.self, forKey: .projects)
        self.web = try attributes.decode(String.self, forKey: .web)
        self.country = try attributes.decode(String.self, forKey: .country)
        self.logo = try attributes.decode(String.self, forKey: .logo)
        
    }
    
    
}
