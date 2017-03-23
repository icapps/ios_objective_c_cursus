//
//  PostService.swift
//  Objective-C
//
//  Created by Ben Algoet on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

import Faro

class PostService: BridgeFaroService {
    
    func post(posts: @escaping ([Post]) -> Void, fail: @escaping (String) -> Void) {
        let _ = fetchPost(BridgeCall("posts"), posts: posts, fail: fail)
    }
    
    func fetchPost(_ call: BridgeCall, posts: @escaping ([Post]) -> Void, fail: @escaping (String) -> Void) -> URLSessionDataTask? {
        return service.perform(call.call) { (result: Result<Post>) in
            switch result {
            case .models(let models):
                guard let models = models else {
                    fail("Fail")
                    return
                }
                posts(models)
            case .failure(let error):
                fail("\(error)")
            default:
                fail("Fail")
            }
        }
    }
    
}
