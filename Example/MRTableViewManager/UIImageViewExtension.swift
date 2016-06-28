//
//  UIImageExtension.swift
//  MRTableViewManager
//
//  Created by Marcelo Reis on 6/27/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//
import UIKit

extension UIImageView {
	
	
	func loadImageFromUrl(urlString:String)
	{
		let imgURL: NSURL = NSURL(string: urlString)!
		let request: NSURLRequest = NSURLRequest(URL: imgURL)
		
		let session = NSURLSession.sharedSession()
		let task = session.dataTaskWithRequest(request){
			(data, response, error) -> Void in
			
			if (error == nil && data != nil)
			{
				func display_image()
				{
					self.image = UIImage(data: data!)
				}
				
				dispatch_async(dispatch_get_main_queue(), display_image)
			}
		}
		
		task.resume()
	}
}