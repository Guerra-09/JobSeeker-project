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
        let url = "https://www.getonbrd.com/api/v0/companies?per_page=20&page=1"
        
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

