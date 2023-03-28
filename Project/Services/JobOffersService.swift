//
//  JobOffersService.swift
//  Project
//
//  Created by José Guerra on 22-03-23.
//

import Foundation
import Alamofire

class JobOfferService {
    
    //private var jobOfferDelegate: CompanyControllerProtocol?
    
    func fetchingOffersData(jobId: String ,completionHandler: @escaping (JobOfferHandler?, Error?) -> Void) {
        
        let url = "https://www.getonbrd.com/api/v0/categories/\(jobId)/jobs?per_page=10&page=1&expand=[%22company%22]"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            
            switch response.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode(JobOfferHandler.self, from: data!)
                    //print("jobOffers: \(jsondata)")
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

