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
    var id: String?
    
    required init?(from raw: Any) {
        print(raw as? [String: Any] ?? "wrong value")
        guard let json = raw as? [String: Any] else { return }
        id <-> json["id"]
    }
    
}
