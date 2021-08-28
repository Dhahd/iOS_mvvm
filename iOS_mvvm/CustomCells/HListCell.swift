//
//  HListCell.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 17/08/2021.
//

import UIKit

class HListCell: UITableViewCell {

	var stores = [Item?]()

	var storeItem: StoreItem!

	@IBOutlet var collectionView: UICollectionView!
	override func awakeFromNib() {
        super.awakeFromNib()
        
    }

	func initCollectionView(){
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	
	func addStores(list: [Item?]?) {
		print("got the list")
		if let list = list {
			initCollectionView()
			let nib = UINib(nibName: "HStoresCell", bundle: nil)
			collectionView.register(nib, forCellWithReuseIdentifier: "hStoreCell")
			let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
			layout.sectionInset = UIEdgeInsets(top:10, left:10 ,bottom:10 ,right:10)
			layout.itemSize = CGSize(width: 220, height: 100)
			 //CGSize(width:300, height:200) CGSize(width:300 UIScreen.main.bounds.size.width/2 - 1, height: 136)
			layout.minimumInteritemSpacing = 10
			layout.minimumLineSpacing = 10
			layout.scrollDirection = .horizontal
			collectionView.collectionViewLayout = layout
			stores = list
			collectionView.reloadData()
		}
	}
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension HListCell: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return stores.count
	}
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hStoreCell", for: indexPath) as! HItemCell
		cell.initViews(item: stores[indexPath.item])
		print("from section collection view \(stores[indexPath.item]?.name)")
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		storeItem.open(item: stores[indexPath.item])
	}
	
}
