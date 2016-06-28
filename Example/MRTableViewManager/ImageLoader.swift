//
//  UIImageExtension.swift
//  MRTableViewManager
//
//  Created by Marcelo Reis on 6/27/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//
import Foundation
import UIKit

class ImageLoader {
	
	var cache = NSCache()
	
	// Singleton
	class var sharedLoader : ImageLoader {
		struct Static {
			static let instance : ImageLoader = ImageLoader()
		}
		return Static.instance
	}
	
	// Getting image from url
	func imageForUrl(urlString: String, completionHandler: (image: UIImage?) -> ()) {
		
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
			
			// Checking image on cache
			let data: NSData? = self.cache.objectForKey(urlString) as? NSData
			if let data = data {
				
				let image = UIImage(data: data)
				
				dispatch_async(dispatch_get_main_queue(), {() in
					
					completionHandler(image: image)
					
					return
					
				})
				
			} else {
				
				// Downloading image
				let downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: { data, response, error in
					
					if (error != nil) {
						
						completionHandler(image: nil)
						
						return
						
					}
					
					if data != nil {
						
						let image = UIImage(data: data!)
						
						// Caching image
						self.cache.setObject(data!, forKey: urlString)
						
						dispatch_async(dispatch_get_main_queue(), {() in
							
							completionHandler(image: image)
							
							return
							
						})
						
					}
					
				})
				
				downloadTask.resume()
				
			}
			
		})
		
	}
	
}