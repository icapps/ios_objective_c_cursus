//
//  PostService.swift
//  Lesson1
//
//  Created by Stefan Adams on 22/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

import Foundation
import Faro

class PostService: FaroSwiftService {
    
    // MARK: - 1 Post
    
    func post(_ id: Int, post: @escaping (Post) -> Void, fail: @escaping (String) -> Void) {
        let _ = fetchPost(FaroCall("posts/\(id)"), post: post, fail: fail)
    }
    
    func fetchPost(_ call: FaroCall, post: @escaping (Post) -> Void, fail: @escaping (String) -> Void) -> URLSessionDataTask? {
        return faroService.perform(call.call) { (result: Result<Post>) in
    		switch result {
            case .model(let model):
                guard let model = model else {
                fail("Fail")
                return
                }
                post(model)
            case .failure(let error):
                fail("\(error)")
            default:
                fail("Fail")
            }
        }
    }
    
    // MARK: - All Posts
    
    func allPosts(post: @escaping ([Post]) -> Void, fail: @escaping (String) -> Void) {
        let _ = fetchAllPosts(FaroCall("posts"), post: post, fail: fail)
    }
    
    func fetchAllPosts(_ call: FaroCall, post: @escaping ([Post]) -> Void, fail: @escaping (String) -> Void) -> URLSessionDataTask? {
        return faroService.perform(call.call) { (result: Result<Post>) in
            switch result {
            case .model(let models):
                guard let models = models else {
                    fail("Fail")
                    return
                }
                post([models])
            case .failure(let error):
                fail("\(error)")
            default:
                fail("Fail")
            }
        }
    }

    
}
