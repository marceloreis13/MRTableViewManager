//
//  TableViewSection.swift
//  Pods
//
//  Created by Marcelo Reis on 6/21/16.
//
//

// MARK: - TableViewSection Class
open class TableViewSection {
	// MARK: Enums and Structs
	
	//Definition of row types
	public enum SectionType:Int {
		case unknow
		case empty
		case preload
		case content
	}
	
	// MARK: - Proprieties
	var rows: [TableViewRow]
	var tag: String
	var type: SectionType
	
	// MARK: - Init
	init(rows: [TableViewRow] = [], tag: String = "", type: SectionType = .unknow){
		self.rows = rows
		self.tag = tag
		self.type = type
	}
	
	func add(_ row: TableViewRow) {
		self.rows.append(row)
	}
}
