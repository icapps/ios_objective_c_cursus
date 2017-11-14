//
//  PostService.swift
//  ObjcTextInput
//
//  Created by Stijn Willems on 14/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

import Foundation
import Faro

class PostService: NSObject {

    @objc var posts: [Post]?
    let service: Service

    @objc override init() {
        let call = Call(path: "posts")
        let session = FaroURLSession(backendConfiguration: BackendConfiguration(baseURL: "http://jsonplaceholder.typicode.com"))
        service = Service(call: call, session: session)
    }

    @objc func getPosts(_ done: @escaping () -> Void) {
        service.perform([Post].self) { (doneService) in
            self.posts = try? doneService()
            done()
        }
    }

}
