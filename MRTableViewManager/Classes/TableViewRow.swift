//
//  TableViewRow.swift
//  Pods
//
//  Created by Marcelo Reis on 6/21/16.
//
//

// MARK: - TVRow Class
open class TableViewRow {
	// MARK: Proprieties
    open let data: [String: AnyObject]
	
	// MARK: Init
	public init(data: [String: AnyObject]){
		self.data = data
	}
}
