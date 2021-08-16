//
//  VStoreCell.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 17/08/2021.
//

import UIKit

class VStoreCell: UITableViewCell {

	@IBOutlet var storeImage: UIImageView!
	@IBOutlet var storeTitle: UILabel!
	@IBOutlet var storeDescription: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
		storeImage.layer.cornerRadius = 15
    }

	func initViews(item: ShopsModelElement?){
		if let item = item {
			storeImage.setImage(item.imageURL)
			storeTitle.setText(item.name)
			storeDescription.setText(item.shopsModelDescription)
		}
	}
    
}
