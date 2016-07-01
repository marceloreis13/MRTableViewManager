//
//  MRContentTableViewCell.swift
//  MRTableViewManager
//
//  Created by Marcelo Reis on 6/25/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import MRTableViewManager

class MRContentTableViewCell: TableViewCell {
	// MARK: - Attribures
	
	// Statics
	static let storyboardId:String = "MRContentTableViewCell"
	
	// MARK: - Outlets
	
	//Images
	@IBOutlet weak var imgCharacter: UIImageView!
	
	//Labels
	@IBOutlet weak var labelCharacter: UILabel!
	@IBOutlet weak var labelActor: UILabel!
	@IBOutlet weak var labelBio: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
		
		self.labelCharacter.text = ""
		self.labelActor.text = ""
		self.labelBio.text = ""
		self.imgCharacter.image = UIImage()
    }
	
	override func updateViewData() {
		if let _character = self.row?.data["character"] as? String {
			self.labelCharacter.text = _character
		}
		if let _actor = self.row?.data["actor"] as? String {
			self.labelActor.text = _actor
		}
		if let _bio = self.row?.data["bio"] as? String {
			self.labelBio.text = _bio
		}
		if let _image = self.row?.data["image"] as? String {
			ImageLoader.sharedLoader.imageForUrl(_image, completionHandler: { loadedImage in
				
				if loadedImage != nil {
					self.imgCharacter.image = loadedImage
					self.imgCharacter.fixContent(.Top)
					self.setNeedsLayout()
				}
				
			})
		}
	}

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
