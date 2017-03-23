//
//  Post.swift
//  Objective-C
//
//  Created by Ben Algoet on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

import Faro

class Post: NSObject, Deserializable {
    
    var userId: Int = 0
    var id: Int = 0
    var title: String = ""
    var body: String = ""
    
    required init?(from raw: Any) {
        guard let json = raw as? [String: Any] else {
            return
        }
        
        userId = json["userId"] as! Int
        id = json["id"] as! Int
        title = json["title"] as! String
        body = json["body"] as! String
     }
    
}
