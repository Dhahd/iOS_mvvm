//
//  ApiCall.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 16/08/2021.
//

import Foundation

enum ApiResponse<Model: Encodable> {
	case success(model: Model)
	case failure(String)
	case null
}
