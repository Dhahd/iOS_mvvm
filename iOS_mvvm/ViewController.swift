//
//  ViewController.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 16/08/2021.
//

import UIKit

class ViewController: UIViewController {
	
	var viewModel: StoreViewModel!
	@IBOutlet var tableView: UITableView!
	
	var storesData = [MainData]()
	
	var stores: [Item?]!
	
	lazy var HEIGHT = { [self] in
		return CGFloat(stores.count > 4 ? 1.0 : 1.2)
	}
	
	lazy var VERTICAL_CELL_SIZE = {
		return self.view.bounds.size.height * CGFloat(self.HEIGHT())
	}
	
	let HORIZONTAL_CELL_SIZE = CGFloat(120)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initAndCallViewModel()
	}
	
	func initTableView(){
		DispatchQueue.main.async {
			self.tableView.dataSource = self
			self.tableView.delegate = self
			self.tableView.reloadData()
			
		}
		
	}
	
	func initAndCallViewModel(){
		self.viewModel = StoreViewModel()
		self.viewModel.bindStoresViewModelToController = { [self] in
			self.stores = self.viewModel.stores
			stores.append(contentsOf: viewModel.stores)
			storesData.append((MainData(itemType: .Horizontal, items: stores)))
			storesData.append((MainData(itemType: .Vertical, items: stores)))
			self.initTableView()
			print("response \(String(describing: self.viewModel.stores))")
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


