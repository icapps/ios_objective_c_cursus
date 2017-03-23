//
//  FaroCall.swift
//  Lesson1
//
//  Created by Stefan Adams on 23/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

import Foundation
import Faro

class FaroCall: NSObject {
    let call: Call
    
    init(_ path: String) {
        call = Call(path: path)
        return
    }
}
