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
	
	var cache = NSCache<AnyObject, AnyObject>()
	
	// Singleton
	class var sharedLoader : ImageLoader {
		struct Static {
			static let instance : ImageLoader = ImageLoader()
		}
		return Static.instance
	}
	
	// Getting image from url
	func imageForUrl(urlString: String, completionHandler: @escaping (_ image: UIImage?) -> ()) {
        
        DispatchQueue.global().async {
            // Checking image on cache
            let data: NSData? = self.cache.object(forKey: urlString as AnyObject) as? NSData
            if let data = data {
                
                let image = UIImage(data: data as Data)
                
                DispatchQueue.main.async(execute: {
                    completionHandler(image)
                    return
                })
                
            } else {
                
                // Downloading image
                let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { data, response, error in
                    
                    if (error != nil) {
                        completionHandler(nil)
                        
                        return
                    }
                    
                    if data != nil {
                        
                        let image = UIImage(data: data!)
                        
                        // Caching image
                        self.cache.setObject(data! as AnyObject, forKey: urlString as AnyObject)
                        
                        DispatchQueue.main.async(execute: {
                            completionHandler(image)
                            
                            return
                        })
                    }
                })
                
                downloadTask.resume()
            }
        }
	}
	
}
