//
//  SwiftViewController.swift
//  Objective-C
//
//  Created by Stijn Willems on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

import UIKit

class UpdateHandlerViewModel {

	let updateHandler: () -> Void

	init(updateHandler: @escaping () -> Void) {
		self.updateHandler = updateHandler
	}

	func didLoadFromService() {
		self.updateHandler()
	}

}

class SwiftViewController: UIViewController {

	var viewModel: UpdateHandlerViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel = UpdateHandlerViewModel {
			print("Update");
		}

	}

}
