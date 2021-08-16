//
//  ShopsModel.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 16/08/2021.
//

import Foundation

// MARK: - ShopsModelElement
struct ShopsModelElement: Codable {
	let id, createdAt: String
	let updatedAt, deletedAt: String?
	let isDeleted: Bool
	let name, shopsModelDescription: String
	let lang, lat: Double
	let imageURL: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case createdAt = "created_at"
		case updatedAt = "updated_at"
		case deletedAt = "deleted_at"
		case isDeleted = "is_deleted"
		case name
		case shopsModelDescription = "description"
		case lang, lat
		case imageURL = "image_url"
	}
}

typealias ShopsModel = [ShopsModelElement]

// MARK: - Encode/decode helpers


