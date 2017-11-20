//
//  BridgeCall.swift
//  Objective-C
//
//  Created by Stijn Willems on 22/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

import Faro

class BridgeCall: NSObject {
	let call: Call

	init(_ path: String) {
		call = Call(path: path)
		return
	}

}
