//
//  IngredientsResult.swift
//  Lesson1
//
//  Created by Stefan Adams on 22/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

import Faro

struct IngredientsResult: Deserializable {
    let ingredient: String
    
    init?(from raw: Any) {
        guard let json = raw as? [String: Any] else {
            return nil
        }
        
        do {
            ingredient = try parse("ingredients", from: json)
        } catch {
            return nil
        }
    }
    
}

