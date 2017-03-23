//
//  Post.swift
//  Objective-C
//
//  Created by Ben Algoet on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

import Faro

class Post: NSObject, Deserializable {
    
    var userId: NSNumber?
    var id: NSNumber?
    var title: String?
    var body: String?
    
    required init?(from raw: Any) {
        guard let json = raw as? [String: Any] else {
            return
        }
        
        userId = json["userId"] as? NSNumber
        id = json["id"] as? NSNumber
        title <-> json["title"]
        body <-> json["body"]
     }
    
}
