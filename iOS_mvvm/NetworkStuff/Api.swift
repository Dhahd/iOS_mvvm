//
//  Api.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 16/08/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class Api: NSObject {
	
	private let af = Alamofire.AF
	
	func getStores(mainResponse: @escaping (ApiResponse<MainResponse?>) -> Void){
		makeRequest("gallery") { response in
			mainResponse(response)
		}
	}
	
	private func makeRequest<Model: Decodable>(_ path: String, parameter: Parameters? = nil, method: HTTPMethod = .get,encoding:ParameterEncoding = URLEncoding.default, mainResponse: @escaping (ApiResponse<Model?>) -> Void)  {
		af.request(url(path),method: method).response { (response) in
			mainResponse(self.parseJSON(data: response.data))
		}
	}
	
	
	private let BaseUrl = "http://csuot.herokuapp.com/v1/"
	
	private func url(_ path: String) -> String {
		return BaseUrl + path
	}
	
	private func parseJSON<Model: Decodable>(data: Data?) -> ApiResponse<Model?> {
		
		if let safeData = data {
			do {
				let data = try JSONDecoder().decode(Model.self, from: safeData)
				print("data \(data)")
				return .success(model: data)
			} catch {
				print("data erorr \(error)")
				if let error = String(data: safeData, encoding: .utf8) {
					return .failure(error)
				}
			}
		}
		
		return .null
	}
	private func newJSONDecoder() -> JSONDecoder {
		let decoder = JSONDecoder()
		if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
			decoder.dateDecodingStrategy = .iso8601
		}
		return decoder
	}
}
