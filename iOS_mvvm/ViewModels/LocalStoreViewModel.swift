//
//  LocalStoreViewModel.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 28/08/2021.
//

import Foundation

class LocalStoreViewModel: NSObject {
	private var api: Api!
	
	var bindStoresViewModelToController : (() -> ()) = {}
	
	private(set) var stores : [Item?]! {
		didSet {
			self.bindStoresViewModelToController()
		}
	}
	
	override init() {
		super.init()
		self.api = Api()
		getStores()
	}
	
	func getStores(){
		
	}
	
}
