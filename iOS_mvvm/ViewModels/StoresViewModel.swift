//
//  StoresViewModel.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 17/08/2021.
//

import Foundation

class StoreViewModel: NSObject {
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
		api.getStores { stores in
			switch stores {
				case .success(model: let model):
					print("success \(String(describing: model))")
					self.stores = model?.items
				case .failure(let error):
					print("error \(error)")
				case .null:
					break
			}
		}
	}
	
}
