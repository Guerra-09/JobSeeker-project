//
//  OfferDetailsViewControllerTests.swift
//  Project
//
//  Created by José Guerra on 11-04-23.
//

import XCTest
@testable import Project

final class OfferDetailsViewControllerTests: XCTestCase {
    
    
    // Testing Work position
    func test_setUpJobType_validNumbers() {
        let sut = OfferDetailsViewController()
        
        let actual = sut.setUpJobType(modalityId: 1)
        let expected = "Full Time"
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_setUpJobType_invalidNumbers() {
        let sut = OfferDetailsViewController()
        
        let actual = sut.setUpJobType(modalityId: 7)
        let expected = "No especificado"
        
        XCTAssertEqual(actual, expected)
    }
    
    // Testing the modality: if it's remote or dont.
    func test_setUpModality() {
        let sut = OfferDetailsViewController()
        
        let actual = sut.setUpRemoteModality(modalidad: "fully_remote")
        let expected = "Modalidad: Remoto"
        
        XCTAssertEqual(actual, expected)
        
    }

}
