//
//  HStoresCell.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 17/08/2021.
//

import UIKit

class HItemCell: UICollectionViewCell {

	@IBOutlet var container: UIView!
	@IBOutlet var title: UILabel!
	@IBOutlet var image: UIImageView!
	override func awakeFromNib() {
        super.awakeFromNib()
		container.layer.cornerRadius = 10
		container.clipsToBounds = true
    }
	
	func initViews(item: Item?) {
		if let item = item {
			image.setImage(item.imageURL)
			title.setText(item.name)
		}
	}

}
