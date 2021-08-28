//
//  MapsViewController.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 28/08/2021.
//

import UIKit
import GoogleMaps
class MapsViewController: UIViewController {
	
	@IBOutlet var collectionView: UICollectionView!
	@IBOutlet var mapContainer: UIView!
	var stores: [Item?]!
	var viewModel: StoreViewModel!
	
	var mapView: GMSMapView!
	
	var markerName: String!
	var markerDescription: String!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Zoom at Baghdad.
		let camera = GMSCameraPosition.camera(withLatitude: 33.325552, longitude:  44.41779, zoom: 14)
		mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
		mapContainer.addSubview(mapView)
			
		stores = getLocalData()
		initViewModel()
		initCollectionView()
		
	}
	
	
	func initCollectionView(){
		collectionView.delegate = self
		collectionView.dataSource = self
		let nib = UINib(nibName: "HStoresCell", bundle: nil)
		collectionView.register(nib, forCellWithReuseIdentifier: "hStoreCell")
		let layout:UICollectionViewFlowLayout = SnappingCollectionViewLayout()
		layout.sectionInset = UIEdgeInsets(top:10, left:10 ,bottom:10 ,right: view.bounds.width / 2)
		layout.itemSize = CGSize(width: 220, height: 100)
		layout.minimumInteritemSpacing = 10
		layout.minimumLineSpacing = 10
		layout.scrollDirection = .horizontal
		collectionView.decelerationRate = .fast
		collectionView.collectionViewLayout = layout
	}
	
	func initViewModel(){
		viewModel = StoreViewModel()
		viewModel.bindStoresViewModelToController = { [self] in
			
			if stores != viewModel.stores {
				stores = viewModel.stores
			}
			
			saveDataLocally()
			
			let firstItem = stores.first
			let lat = firstItem??.lat
			let lang = firstItem??.lang
			//setupMarker(index: 0)
			
			DispatchQueue.main.async {
				
				zoomToCords(lat, lang)
				collectionView.reloadData()
				mapContainer.bringSubviewToFront(collectionView)
			}
			
		}
	}
	
	func zoomToCords(_ lang: Double?,_ lat: Double?) {
		if let lat = lat, let lang = lang {
			
			mapView.clear()
			let marker = GMSMarker()
			marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lang)
			marker.title = markerName
			marker.snippet = markerDescription
			marker.map = mapView
			mapView.animate(toLocation: CLLocationCoordinate2D(latitude: lat, longitude: lang))
			mapView.animate(toZoom: 16)
			
		}
	}
	
	private func setupMarker(index: Int?) {
		if let index = index {
			let item = stores[index]
			markerName = item?.name
			markerDescription = item?.itemDescription
		}
	}
	func saveDataLocally(){
		let jsonStores = try! JSONEncoder().encode(stores)
		
		if let jsonString = String(data: jsonStores, encoding: .utf8) {
			saveData(stores: jsonString)
		}
	}
}
extension MapsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return stores.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hStoreCell", for: indexPath) as! HItemCell
		cell.initViews(item: stores[indexPath.item])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let lat = stores[indexPath.item]?.lat
		let lang = stores[indexPath.item]?.lang
		
		setupMarker(index: indexPath.item)
		zoomToCords(lat, lang)
		collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let indexPath = firstCellIndex()
		let lat = stores[indexPath]?.lat
		let lang = stores[indexPath]?.lang

		setupMarker(index: indexPath)
		zoomToCords(lat, lang)
		
	}
	
	func firstCellIndex() -> Int {
		var visibleRect = CGRect()
		visibleRect.origin = collectionView.contentOffset
		visibleRect.size = collectionView.bounds.size
		let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
		guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return 0 }
		return indexPath.item
	}
	
	
}
