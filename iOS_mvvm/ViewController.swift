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
	private var dataSource : StoresTableView<VStoreCell,ShopsModel>!

	override func viewDidLoad() {
		super.viewDidLoad()
		initAndCallViewModel()
//		let nib = UINib(nibName: "VStoreCell", bundle: nil)
//		tableView.register(nib, forCellReuseIdentifier: "Vstore")
	}

	func initTableView(){
		self.dataSource = StoresTableView(cellName: "VStoreCell", cellIdentifier: "Vstore", items: self.viewModel.stores, configureCell: { (cell, evm) in
			cell.initViews(item: evm)
		})
		
		DispatchQueue.main.async {
			self.tableView.dataSource = self.dataSource
			self.tableView.reloadData()
		}
	//	tableView.delegate = self
		//tableView.dataSource = self
	}
	
	func initAndCallViewModel(){
		self.viewModel = StoreViewModel()
		self.viewModel.bindStoresViewModelToController = {
			self.initTableView()
			print("response \(self.viewModel.stores)")
		}
	}

}


