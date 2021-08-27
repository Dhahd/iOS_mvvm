//
//  MainData.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 27/08/2021.
//

import Foundation

struct MainData: Codable {
	var itemType: ItemType
	var items: [Item?]
	
}
enum ItemType: String, Codable {
	
	case Vertical
	case Horizontal
	
}
