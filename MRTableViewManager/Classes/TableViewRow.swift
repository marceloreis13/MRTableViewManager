//
//  TableViewRow.swift
//  Pods
//
//  Created by Marcelo Reis on 6/21/16.
//
//

import SwiftyJSON

// MARK: TVRow Class
public class TableViewRow {
	// MARK: Proprieties
	public let data: SwiftyJSON.JSON!
	
	// MARK: Init
	public init(data: SwiftyJSON.JSON){
		self.data = data
	}
}
