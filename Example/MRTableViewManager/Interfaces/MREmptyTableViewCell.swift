//
//  MREmptyTableViewCell.swift
//  MRTableViewManager
//
//  Created by Marcelo Reis on 6/25/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import MRTableViewManager

class MREmptyTableViewCell: TableViewCell {
	// MARK: - Attribures
	
	// Statics
	static let storyboardId:String = "MREmptyTableViewCell"
	
	// MARK: - Outlets
	
	//Labels
	@IBOutlet weak var labelEmpty: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		self.labelEmpty.text = "-Nothing to show-"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
