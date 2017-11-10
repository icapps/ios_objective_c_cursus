//
//  TextViewModel.swift
//  ObjcTextInput
//
//  Created by Stijn Willems on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

import Foundation

class TextViewModel: NSObject {
    @objc let text: String

    @objc init(text: String) {
        self.text = text
        super.init()
    }

    @objc func foo() {
        
    }
}
