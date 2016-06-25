//
//  TableViewManager.swift
//  Pods
//
//  Created by Marcelo Reis on 6/21/16.
//
//

import SwiftyJSON

// MARK: Table View Manager Delegate
public protocol TableViewManagerDelegate {
	// Attributes
	func next(callback: (TableViewManager.Callback)?)
	func getTableView() -> UITableView
}

// MARK: TableViewRowManager Class
public class TableViewManager {
	// MARK: - Type Alias
	public typealias Callback = () -> ()
	public typealias SectionType = TableViewSection.SectionType
	
	// MARK: - Private Atributtes
	private var _sections:[TableViewSection]
	private var _preloadItems:Int = 3
	
	// MARK: - Public Atributtes
	public var delegate: TableViewManagerDelegate?
	public var tableViewManager: UITableView?
	public var currentPage: Int = 1
	
	// MARK: - Init
	public init(){
		//Start _sections
		self._sections = [TableViewSection]()
		
		//Action preload
		self.addPreload()
	}
	
	
	// MARK: - Private functions
	private func _tableViewReloadData(){
		//Reload table view data after fill section
		if let _tableView = self.delegate?.getTableView() {
			dispatch_async(dispatch_get_main_queue(), {
				_tableView.reloadData()
			})
		}else{
			print("Missing tableViewManager")
		}
	}
	
	private func _processRowsData(data: SwiftyJSON.JSON) -> [TableViewRow]{
		// Rows map
		var _rows:[TableViewRow] = []
		
		//Loop with data received
		for (_, n) in data {
			_rows.append(TableViewRow(data: n))
		}
		
		return _rows
	}
	
	private func _addSection(data: JSON, tag:String = "", type:SectionType = .Unknow) -> TableViewSection {
		//Remove preload before add any section
		self._removePreload()
		
		//Remove empties before add any section
		self._removeEmpty()
		
		var _rows = self._processRowsData(data)
		var _type = type
		
		if _rows.isEmpty {
			_rows = self._processRowsData(JSON([]))
			_type = .Empty
		}
		
		let _section:TableViewSection = TableViewSection(rows: _rows, tag: tag, type: _type)
		self._sections.append(_section)
		
		//Reload table view data after fill section
		self._tableViewReloadData()
		
		return _section
	}
	
	//Remove preload
	private func _removePreload(){
		guard self._preloadItems > 0 else {return}
		guard self._sections.first != nil else {return}
		
		if self._sections.first!.type == .Preload {
			self._sections.removeFirst()
		}
		
	}
	
	//Remove empties
	private func _removeEmpty(){
		guard self._sections.last != nil else {return}
		
		if self._sections.last!.type == .Empty {
			self._sections.removeLast()
		}
	}
	
	// MARK: - Public functions
	public func addSection(data: JSON, tag:String = "") -> TableViewSection {
		var _data = data
		if data.arrayObject == nil {
			_data = JSON([data])
		}
		let _section = self._addSection(_data, tag: tag, type: .Content)
		
		return _section
	}
	
	public func addSectionScrollingToEnd(data: JSON, tag:String = ""){
		//Add Section
		let _section = self.addSection(data, tag: tag)
		
		//Scrolling to end
		let _rowEndIndex = _section.rows.endIndex - 1
		let _sectionEndIndex = self._sections.endIndex - 1
		let indexPath = NSIndexPath(forRow: _rowEndIndex, inSection: _sectionEndIndex)
		if let _tableView = self.delegate?.getTableView() {
			_tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
		}else{
			print("Missing tableViewManager")
		}
	}
	
	// Fill the _section with preload data
	public func addPreload() -> TableViewSection{
		guard self._preloadItems > 0 else {return TableViewSection()}
		
		self.clear()
		
		let _empty = JSON([])
		var _rows = [TableViewRow]()
		for _ in 1...self._preloadItems {
			_rows.append(TableViewRow(data: _empty))
		}
		
		let _section:TableViewSection = TableViewSection(rows: _rows, tag: "preload", type: .Preload)
		
		self._sections.append(_section)
		
		//Reload table view data after fill section
		self._tableViewReloadData()
		
		return _section
	}
	
	public func clear(){
		guard !self._sections.isEmpty else {return}
		
		self.currentPage = 1
		
		self._sections = [TableViewSection]()
	}
	
	public func clearKeepingFirst(){
		guard !self._sections.isEmpty else {return}
		guard self._sections.count >= 1 else {return}
		
		let _firstSection = self._sections.first
		self.clear()
		self._sections.append(_firstSection!)
	}
	
	public func sectionType(section: Int) -> SectionType{
		guard !self._sections.isEmpty else {return SectionType.Unknow}
		
		return self._sections[section].type
	}
	
	public func sectionTag(section: Int) -> String{
		guard !self._sections.isEmpty else {return ""}
		
		return self._sections[section].tag
	}
	
	public func get(indexPath: NSIndexPath) -> TableViewRow {
		guard !self._sections.isEmpty && !self._sections[indexPath.section].rows.isEmpty else {return TableViewRow(data: JSON([]))}
		
		return self._sections[indexPath.section].rows[indexPath.row]
	}
	
	public func remove(indexPath: NSIndexPath){
		guard !self._sections.isEmpty && !self._sections[indexPath.section].rows.isEmpty else {return}
		
		self._sections[indexPath.section].rows.removeAtIndex(indexPath.row)
	}
	
	//Total of sections
	public func total() -> Int{
		return self._sections.count
	}
	
	//Total of rows in specific section
	public func total(section: Int) -> Int{
		guard self._sections[section].type != SectionType.Empty else {
			return 1
		}
		return self._sections[section].rows.count
	}
	
}