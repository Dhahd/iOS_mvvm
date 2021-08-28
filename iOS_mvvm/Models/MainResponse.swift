//
//  MainResponse.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 27/08/2021.
//

import Foundation
import CoreData
// MARK: - MainResponse
struct MainResponse: Codable {
	let count: Int
	let items: [Item]
}

// MARK: - Item
struct Item: Codable, Equatable {
	let id, createdAt: String
	let updatedAt, deletedAt: String?
	let isDeleted: Bool
	let name, itemDescription: String
	let lang, lat: Double
	let imageURL: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case createdAt = "created_at"
		case updatedAt = "updated_at"
		case deletedAt = "deleted_at"
		case isDeleted = "is_deleted"
		case name
		case itemDescription = "description"
		case lang, lat
		case imageURL = "image_url"
	}
}
//
//@objc(Stores)
//public class Stores: NSManagedObject {
//
//	@NSManaged var id, createdAt: String
//	@NSManaged var updatedAt, deletedAt: String?
//	@NSManaged var isItemDeleted: Bool
//	@NSManaged var name, itemDescription: String
//	@NSManaged var lang, lat: Double
//	@NSManaged var imageURL: String
//
//
//
//	var allAtributes : Item {
//		get {
//			return Item(id: self.id, createdAt: self.createdAt, updatedAt: self.updatedAt, deletedAt: self.deletedAt, isDeleted: self.isItemDeleted, name: self.name, itemDescription: self.itemDescription, lang: self.lang, lat: self.lat, imageURL: self.imageURL)
//		}
//		set {
//			self.id = newValue.id
//			self.createdAt = newValue.createdAt
//			self.updatedAt = newValue.updatedAt
//			self.deletedAt = newValue.deletedAt
//			self.isItemDeleted = newValue.isDeleted
//			self.name = newValue.name
//			self.itemDescription = newValue.itemDescription
//			self.lang = newValue.lang
//			self.lat = newValue.lat
//			self.imageURL = newValue.imageURL
//		}
//	}
//
//}
