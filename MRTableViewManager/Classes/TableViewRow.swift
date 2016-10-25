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
    open let data: AnyObject
	
	// MARK: Init
    public init(data: AnyObject){
        self.data = data
    }
    
    public init(){
        self.data = [AnyObject]() as AnyObject
    }
}
