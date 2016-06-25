//
//  TableViewSection.swift
//  Pods
//
//  Created by Marcelo Reis on 6/21/16.
//
//

import SwiftyJSON

// MARK: - TVRow Class
public class TableViewSection {
	// MARK: Enums and Structs
	
	//Definition of row types
	public enum SectionType:Int {
		case Unknow
		case Empty
		case Preload
		case Content
	}
	
	// MARK: - Proprieties
	var rows: [TableViewRow]
	var tag:String
	var type: SectionType
	
	// MARK: - Init
	init(rows: [TableViewRow] = [], tag:String = "", type: SectionType = .Unknow){
		self.rows = rows
		self.tag = tag
		self.type = type
	}
	
	func add(row: TableViewRow){
		self.rows.append(row)
	}
}

