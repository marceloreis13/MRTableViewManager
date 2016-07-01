//
//  UIImageViewExtension.swift
//  MRTableViewManager
//
//  Created by Marcelo Reis on 6/27/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//
import Foundation
import UIKit

extension UIImageView {
	
	// Fit image height or width
	func fixContent(contentMode:UIViewContentMode = .ScaleAspectFill) {
		
		self.clipsToBounds = true
		self.contentMode = contentMode
		
	}
	
}