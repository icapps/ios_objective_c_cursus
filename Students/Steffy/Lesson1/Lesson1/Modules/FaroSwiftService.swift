//
//  FaroSwiftService.swift
//  Lesson1
//
//  Created by Stefan Adams on 22/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

import Foundation
import Faro

class FaroSwiftService: NSObject {
    
    let faroService: Service
    
//    init(with service: Service = FaroService.shared) {
//        self.faroService = service
//    }

    override init() {
        faroService = Service(configuration: Configuration(baseURL: "http://jsonplaceholder.typicode.com"))
    }
    
}
