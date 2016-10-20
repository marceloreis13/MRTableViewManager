//
//  Serializer.swift
//  TableViewManager
//
//  Created by Marcelo Reis on 6/22/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

// JSON Serializer helper class
final class Serializer {
	
	// Retrieve JSON from Url and tries to parse it
	static func jsonFromUrl(url: String, completionHandler: @escaping (NSDictionary) -> (), errorHandler: @escaping (NSError?) -> ()) {
		
		let url = NSURL(string: url)
		
		let task = URLSession.shared.dataTask(with: url! as URL) {(data, response, error) in
			
			if error != nil {
				errorHandler(error as NSError?)
			} else {
				let result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
				completionHandler(Serializer.jsonFromString(json: result!))
			}
			
		}
		
		task.resume()
	}
	
	// Convert JSON string to NSDictionary
	static func jsonFromString(json: NSString) -> NSDictionary {
		
		// convert String to NSData
		let data = json.data(using: String.Encoding.utf8.rawValue)
		var error: NSError?
		
		// convert NSData to 'AnyObject'
		let anyObj: Any?
		
		do {
			
            anyObj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
			
		} catch let error1 as NSError {
			
			error = error1
			anyObj = nil
			
		}
		
		if(error != nil) {
			
			print("JSON Error \(error!.localizedDescription)")
			return NSDictionary()
			
		} else {
			
			return anyObj as! NSDictionary
		}
		
	}
	
}
