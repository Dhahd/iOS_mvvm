//
//  LocalStoreViewModel.swift
//  iOS_mvvm
//
//  Created by Hadi Dhahd on 28/08/2021.
//

import Foundation
import UIKit
import CoreData

class LocalStoreViewModel: NSObject {
	
	private var app = UIApplication.shared.delegate as! AppDelegate
	private lazy var context = {
		return self.app.persistentContainer.viewContext
	}
	
	var stores : [Item?]!
	
	
	override init() {
		super.init()
		stores = getLocalData()
	}
	
	func saveData(stores: String?)
	{
		
		clearStores()
		
		let entity =
			NSEntityDescription.entity(forEntityName: "Stores",
									   in: context())!
		
		let person = NSManagedObject(entity: entity,
									 insertInto: context())
		
		person.setValue(stores, forKeyPath: "stores")
		
		do {
			try context().save()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
	
	
	func getSavedStores() -> String? {
		
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Stores")
		//request.predicate = NSPredicate(format: "age = %@", "12")
		request.returnsObjectsAsFaults = false
		do {
			let result = try context().fetch(request)
			let data = (result.first as? NSManagedObject)?.value(forKey: "stores") as? String
			return data
			
		} catch {
			print("Failed")
		}
		return nil
	}
	
	func clearStores() {
		
		let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Stores")
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
		do
		{
			try context().execute(deleteRequest)
			try context().save()
		}
		catch
		{
			print ("There was an error")
		}
	}
	
	func getLocalData() -> [Item]? {
		
		if let savedData = getSavedStores() {
			let storesData = savedData.data(using: .utf8)
			return parseJSON(data: storesData)
		}
		
		return nil
	}
	
	private func parseJSON(data: Data?) -> [Item]? {
		
		if let safeData = data {
			do {
				let data = try JSONDecoder().decode([Item].self, from: safeData)
				return data
			} catch {
				if let error = String(data: safeData, encoding: .utf8) {
					print(error)
				}
			}
		}
		return nil
	}
	private func newJSONDecoder() -> JSONDecoder {
		let decoder = JSONDecoder()
		if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
			decoder.dateDecodingStrategy = .iso8601
		}
		return decoder
	}
	
	
	
}
