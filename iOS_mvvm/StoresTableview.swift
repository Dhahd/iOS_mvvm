//
//  StoresTableview.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 17/08/2021.
//

import Foundation
import UIKit
class StoresTableView<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource, UITableViewDelegate {
	
	private var cellIdentifier : String!
	private var items : [Item]!
	var configureCell : (CELL, Item) -> () = {_,_ in }
	var nibName = ""
	
	init(cellName: String, cellIdentifier : String, items : [Item], configureCell : @escaping (CELL, Item) -> ()) {
		self.cellIdentifier = cellIdentifier
		self.nibName = cellName
		self.items = items
		self.configureCell = configureCell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		tableView.rowHeight = 120
		let nib = UINib(nibName: nibName, bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
		
		let item = self.items[indexPath.row]
		self.configureCell(cell, item)
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		120
	}
	
}

