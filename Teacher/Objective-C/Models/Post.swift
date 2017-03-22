//
//  Post.swift
//  Objective-C
//
//  Created by Stijn Willems on 22/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

import Faro

class Post: NSObject, Deserializable {

	var name: String?

	required init?(from raw: Any) {
		print(raw as? [String: String] ?? "wrong value");
		name  = (raw as? [String: String])?["name"]
	}
	
}
