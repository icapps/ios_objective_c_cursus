//
//  IngredientsRequest.swift
//  Lesson1
//
//  Created by Stefan Adams on 22/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

import Foundation
import Faro

struct IngredientsRequest {
    var call: Call {
        return Call(path: "", method: .GET, rootNode: "")
    }
}
