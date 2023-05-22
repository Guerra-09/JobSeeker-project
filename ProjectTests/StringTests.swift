//
//  StringTests.swift
//  ProjectTests
//
//  Created by José Guerra on 11-04-23.
//

import Foundation
import XCTest

final class StringTest: XCTestCase {
    
    func test_htmlToString_correct() {
        
     
        let actual = "<p>Formación: Ingeniería en Ejecución, Ingeniería Civil Industrial, Ingeniería en Informática. <br>Años de experiencia: Al menos 3 años.</p><ul><li>Conocimiento MS Office</li><li>Conocimientos componentes WEB</li><li>Conocimiento bizagi - Vicio - Projet</li><li>Conocimiento en base de datos</li></ul>".htmlToString
        
        let expected = "Formación: Ingeniería en Ejecución, Ingeniería Civil Industrial, Ingeniería en Informática.  Años de experiencia: Al menos 3 años.\n\t•\tConocimiento MS Office\n\t•\tConocimientos componentes WEB\n\t•\tConocimiento bizagi - Vicio - Projet\n\t•\tConocimiento en base de datos\n"
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_htmlToString_invalidHtml() {
        let actual = "<h1 Hola <h1>".htmlToString
        let expected = "<h1 Hola <h1>"
            
        XCTAssertEqual(actual, expected)
    }
    
    func test_htmlToString_lists() {
        let actual = "<lu><li>Item 1</li> <li>Item 2</li> <li>Item 3</li> </lu>".htmlToString
        print("\(actual).")
        
        let expected = "Item 1\nItem 2\nItem 3\n"
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_htmlToString_empty() {
        
        let actual = "".htmlToString
        
        let expected = ""
        
        XCTAssertEqual(actual, expected)
    }
    
}
