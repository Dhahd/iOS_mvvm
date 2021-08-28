//
//  SingleMapViewController.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 29/08/2021.
//

import Foundation

import UIKit
import GoogleMaps

class SingleMapViewController: UIViewController {
	
	
	var stores: [Item?]?!
	var viewModel: StoreViewModel!
	var localViewModel: LocalStoreViewModel!
	
	var mapView: GMSMapView!
	
	var markerName: String!
	var markerDescription: String!
	
	var lat: Double!
	var lang: Double!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Zoom at Baghdad.
		let camera = GMSCameraPosition.camera(withLatitude: 33.325552, longitude:  44.41779, zoom: 14)
		mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
		view.addSubview(mapView)

		if let lat = lat, let lang = lang {
			navigationController?.navigationBar.isHidden = false
			print("name here also \(markerName), \(lat)")
			zoomToCords(lat, lang)
		}
	}
	
	func zoomToCords(_ lang: Double?,_ lat: Double?) {
		if let lat = lat, let lang = lang {
			let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lang)
			mapView.clear()
			let marker = GMSMarker()
			marker.position = coordinates
			marker.title = markerName
			marker.snippet = markerDescription
			marker.map = mapView
			mapView.animate(toLocation: coordinates)
			mapView.animate(toZoom: 16)
			
		}
	}
}
