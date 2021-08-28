//
//  MainResponse.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 27/08/2021.
//

import Foundation

// MARK: - MainResponse
struct MainResponse: Codable {
	let count: Int
	let items: [Item]
}

// MARK: - Item
struct Item: Codable {
	let id, createdAt: String
	let updatedAt, deletedAt: JSONNull?
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

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
	
	public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
		return true
	}
	
	public var hashValue: Int {
		return 0
	}
	
	public init() {}
	
	public required init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if !container.decodeNil() {
			throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
		}
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encodeNil()
	}
}
