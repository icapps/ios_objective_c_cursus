//
//  Post.swift
//  Lesson1
//
//  Created by Stefan Adams on 22/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

import Foundation
import Faro

class Post: NSObject, Deserializable {
    var title: String?
    var userId: NSNumber?
    var id: NSNumber?
    var body: String?
    
    required init?(from raw: Any) {
        guard let json = raw as? [String: Any] else { return }
        title <-> json["title"]
        userId = json["userId"] as! NSNumber?
        id = json["id"] as! NSNumber?
        body <-> json["body"]
        
        
        print("ID:", id ?? "no ID")
        print("USERID:", userId ?? "no userId")
        print("TITLE:", title ?? "no title")
        print("BODY:", body ?? "no body")
    }
    
}
