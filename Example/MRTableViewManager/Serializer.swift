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
	static func jsonFromUrl(url: String, completionHandler: (NSDictionary) -> (), errorHandler: (NSError?) -> ()) {
		
		let url = NSURL(string: url)
		
		let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
			
			if error != nil {
				errorHandler(error)
			} else {
				let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
				completionHandler(Serializer.jsonFromString(result!))
			}
			
		}
		
		task.resume()
	}
	
	// Convert JSON string to NSDictionary
	static func jsonFromString(json: NSString) -> NSDictionary {
		
		// convert String to NSData
		let data = json.dataUsingEncoding(NSUTF8StringEncoding)
		var error: NSError?
		
		// convert NSData to 'AnyObject'
		let anyObj: AnyObject?
		
		do {
			
			anyObj = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
			
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