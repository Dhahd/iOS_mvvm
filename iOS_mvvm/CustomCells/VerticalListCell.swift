//
//  VerticalListCell.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 27/08/2021.
//

import UIKit

class VerticalListCell: UITableViewCell {
	
	var stores: [Item?]!
	
	@IBOutlet var tableView: UITableView!
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func addItems(items: [Item?]?){
		if let items = items {
			tableView.delegate = self
			tableView.dataSource = self
			stores = items
			tableView.reloadData()
		}
	}

	
	
}
extension VerticalListCell: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		stores.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let nib = UINib(nibName: "VItemCell", bundle: nil)
		self.tableView.register(nib, forCellReuseIdentifier: "Vstore")
		let cell = tableView.dequeueReusableCell(withIdentifier: "Vstore", for: indexPath) as! VItemCell
		cell.initViews(item: stores[indexPath.item])
		return cell
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		100
	}
	
}
