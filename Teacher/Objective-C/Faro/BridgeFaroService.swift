//
//  BridgeFaroService.swift
//  Objective-C
//
//  Created by Stijn Willems on 22/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

import Faro

class BridgeFaroService: NSObject {
	let service: Service

	override init() {
		service = Service(configuration: Configuration(baseURL: "http://jsonplaceholder.typicode.com"))
	}

	
	
}
