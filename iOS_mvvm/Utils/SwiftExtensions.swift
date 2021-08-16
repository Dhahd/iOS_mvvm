//
//  SwiftExtensions.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 17/08/2021.
//

import Foundation
import Kingfisher

extension UIImageView {
	func setImage(_ url: String?){
		let loader = self.kf
		loader.indicator?.startAnimatingView()
		
		if let url = url {
			print("img url \(url)")
			
			loader.setImage(with: URL(string: url))
			loader.indicator?.stopAnimatingView()
		}
	}
	
}


extension UILabel {
	func setText(_ text: Any?) {
		if let text = text {
			self.text = text as? String
		}
	}
}
