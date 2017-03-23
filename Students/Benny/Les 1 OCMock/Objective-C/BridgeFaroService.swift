//
//  BridgeFaroService.swift
//  Objective-C
//
//  Created by Ben Algoet on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

import Faro

class BridgeFaroService: NSObject {
    public let service: Service
    
    override init() {
        service = Service(configuration: Configuration(baseURL: "http://jsonplaceholder.typicode.com"))
    }

}
