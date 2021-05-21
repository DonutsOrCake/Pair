//
//  Person.swift
//  Pair
//
//  Created by Bryson Jones on 5/21/21.
//

import Foundation

class Person: Codable {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}
