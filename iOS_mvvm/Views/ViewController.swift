//
//  ViewController.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 16/08/2021.
//

import UIKit
import CoreData
import SwiftyJSON

class ViewController: UIViewController {
	
	var viewModel: StoreViewModel!
	@IBOutlet var tableView: UITableView!
	
	var storesData = [MainData]()
	
	var stores: [Item?]!
	
	lazy var VERTICAL_CELL_SIZE = {
		return self.view.bounds.size.height * 0.8
	}
	
	let HORIZONTAL_CELL_SIZE = CGFloat(110)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		stores = getLocalData()
		initTableView()
		initAndCallViewModel()
		
	}
	
	func initTableView(){
		DispatchQueue.main.async { [self] in
			tableView.dataSource = self
			tableView.delegate = self
			tableView.reloadData()
		}
		
	}
	
	func initAndCallViewModel(){
		self.viewModel = StoreViewModel()
		self.viewModel.bindStoresViewModelToController = { [self] in
			
			if stores != viewModel.stores {
				stores = viewModel.stores
			}
			
			saveDataLocally()
			
			for _ in 0...4 {
				stores.append(contentsOf: viewModel.stores)
			}
			storesData.append((MainData(itemType: .Horizontal, items: stores)))
			storesData.append((MainData(itemType: .Vertical, items: stores)))
			DispatchQueue.main.async {
				tableView.reloadData()
			}
			print("response \(String(describing: viewModel.stores))")
		}
	}
	
	func saveDataLocally(){
		let jsonStores = try! JSONEncoder().encode(stores)
		
		if let jsonString = String(data: jsonStores, encoding: .utf8) {
			saveData(stores: jsonString)
		}
	}
	
	
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		storesData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if storesData[indexPath.item].itemType == .Horizontal {
			return getHorizontalCell(indexPath)
		} else {
			return getVerticalCell(indexPath)
		}
	}
	
	private func getHorizontalCell(_ indexPath: IndexPath) -> UITableViewCell {
		let nib = UINib(nibName: "HListCell", bundle: nil)
		self.tableView.register(nib, forCellReuseIdentifier: "HListCell")
		let cell = tableView.dequeueReusableCell(withIdentifier: "HListCell", for: indexPath) as! HListCell
		cell.addStores(list: stores)
		print("from section 1 \(cell.stores)")
		return cell
	}
	
	private func getVerticalCell(_ indexPath: IndexPath) -> UITableViewCell {
		let nib = UINib(nibName: "VerticalListCell", bundle: nil)
		self.tableView.register(nib, forCellReuseIdentifier: "VlistCel")
		let cell = tableView.dequeueReusableCell(withIdentifier: "VlistCel", for: indexPath) as! VerticalListCell
		cell.addItems(items: stores)
		cell.layoutSubviews()
		
		cell.layoutIfNeeded()

		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if storesData[indexPath.item].itemType == .Horizontal {
			return HORIZONTAL_CELL_SIZE
		} else {
			return VERTICAL_CELL_SIZE()
		}
	}

}


