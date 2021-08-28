//
//  ViewController.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 16/08/2021.
//

import UIKit
import CoreData
import SwiftyJSON

class ViewController: UIViewController, StoreItem {
	func open(item: Item?) {
		if let lat = item?.lat, let lang = item?.lang,
		   let name = item?.name, let description = item?.itemDescription {
			openMap(lat: lat, lang: lang, name: name, description: description)
		}
	}
	
	
	var viewModel: StoreViewModel!
	var localViewmodel: LocalStoreViewModel!
	
	@IBOutlet var tableView: UITableView!
	
	@IBOutlet var indecator: UIActivityIndicatorView!
	var storesData = [MainData]()
	
	var stores: [Item?]!
	
	lazy var VERTICAL_CELL_SIZE = {
		return self.view.bounds.size.height * 0.8
	}
	
	let HORIZONTAL_CELL_SIZE = CGFloat(110)
	override func viewDidAppear(_ animated: Bool) {
		navigationController?.navigationBar.isHidden = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initLocalViewModel()
		initAndCallViewModel()
		initTableView()
	}
	
	func initLocalViewModel(){
		localViewmodel = LocalStoreViewModel()
		stores = localViewmodel.stores
		if let vmStore = localViewmodel.stores {
			
		storesData.append((MainData(itemType: .Horizontal, items: vmStore)))
		storesData.append((MainData(itemType: .Vertical, items: vmStore)))
		indecator.removeFromSuperview()
		}
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
			
			if viewModel.stores != stores {
				stores = viewModel.stores
			
			if let vmStore = viewModel.stores {
			
			storesData.append((MainData(itemType: .Horizontal, items: vmStore)))
			storesData.append((MainData(itemType: .Vertical, items: vmStore)))
			DispatchQueue.main.async {
				tableView.reloadData()
			}
			print("response \(String(describing: viewModel.stores))")
				indecator.removeFromSuperview()
				saveDataLocally(vmStore)
			}
		}
		}
		
	}
	
	func saveDataLocally(_ stores: [Item?]){
		let jsonStores = try! JSONEncoder().encode(stores)
		
		if let jsonString = String(data: jsonStores, encoding: .utf8) {
			localViewmodel.saveData(stores: jsonString)
		}
	}
	
	func openMap(lat: Double, lang: Double, name: String, description: String){
		let mainBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let mapViewController = mainBoard.instantiateViewController(withIdentifier: "map") as! MapsViewController
		
		mapViewController.lat = lat
		mapViewController.lang = lang
		mapViewController.markerName = name
		mapViewController.markerDescription = description
		//self.present(mapViewController, animated: true, completion: nil)
		self.navigationController?.pushViewController(mapViewController, animated: true)
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
		cell.storeItem = self
		return cell
	}
	
	private func getVerticalCell(_ indexPath: IndexPath) -> UITableViewCell {
		let nib = UINib(nibName: "VerticalListCell", bundle: nil)
		self.tableView.register(nib, forCellReuseIdentifier: "VlistCel")
		let cell = tableView.dequeueReusableCell(withIdentifier: "VlistCel", for: indexPath) as! VerticalListCell
		cell.addItems(items: stores)
		cell.storeItem = self
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if storesData[indexPath.item].itemType == .Horizontal {
			return HORIZONTAL_CELL_SIZE
		} else {
			return VERTICAL_CELL_SIZE()
		}
	}
}


