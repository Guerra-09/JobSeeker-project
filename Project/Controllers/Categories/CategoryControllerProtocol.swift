//
//  CategoryControllerProtocol.swift
//  Project
//
//  Created by José Guerra on 15-03-23.
//

import Foundation


protocol CategoryControllerProtocol: AnyObject {
    func showList(list: CategoryHandler)
    func showOfferList(model: [JobOfferModel])
    func showCompanyList(model: [CompanyModel])
    func errorList()
}


