//
//  PostService.swift
//  Objective-C
//
//  Created by Stijn Willems on 22/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

import Faro

class PostService: BridgeFaroService {

	func post(_ id: Int,  post: @escaping (Post) -> Void, fail: @escaping (String) -> Void) {
		let _ = fetchPost(BridgeCall("posts/\(id)"), post: post, fail: fail)
	}

	func fetchPost(_ call: BridgeCall, post: @escaping (Post) -> Void, fail: @escaping (String) -> Void) -> URLSessionDataTask? {
		return service.perform(call.call) { (result: Result<Post>) in
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

}
