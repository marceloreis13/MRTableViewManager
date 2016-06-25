//
//  MRContentTableViewCell.swift
//  MRTableViewManager
//
//  Created by Marcelo Reis on 6/25/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import MRTableViewManager
import SwiftyJSON

class MRContentTableViewCell: TableViewCell {
	// MARK: - Attribures
	
	// Statics
	static let storyboardId:String = "MRContentTableViewCell"
	
	// MARK: - Outlets
	
	//Labels
	@IBOutlet weak var labelContent: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
		
		self.labelContent.text = ""
    }
	
	override func updateViewData() {
		if let _title = self.row?.data["title"].string {
			self.labelContent.text = _title
		}
	}

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
