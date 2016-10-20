//
//  TableViewManager.swift
//  Pods
//
//  Created by Marcelo Reis on 6/21/16.
//
//

import UIKit

// MARK: Table View Manager Delegate
public protocol TableViewManagerDelegate {
	// Attributes
	func next(_ callback: (TableViewManager.Callback)?)
	func getTableView() -> UITableView
}

// MARK: TableViewRowManager Class
open class TableViewManager {
	// MARK: - Type Alias
	public typealias Callback = () -> ()
	public typealias SectionType = TableViewSection.SectionType
	
	// MARK: - Private Atributtes
	fileprivate var _sections: [TableViewSection]
	fileprivate var _preloadItems: Int
	
	// MARK: - Public Atributtes
	open var delegate: TableViewManagerDelegate?
	open var tableViewManager: UITableView?
	open var currentPage: Int = 1
	
	// MARK: - Init
	public init(preloadItems: Int = 1){
		//Start _sections
		self._sections = [TableViewSection]()
		
		//Set how many preloads will be showed
		self._preloadItems = preloadItems
		
		//Action preload
		self.addPreload()
	}
	
	
	// MARK: - Private functions
	fileprivate func _tableViewReloadData() {
		//Reload table view data after fill section
		if let _tableView = self.delegate?.getTableView() {
			DispatchQueue.main.async(execute: {
				_tableView.reloadData()
			})
		}
	}
	
    fileprivate func _processRowsData(_ data: [[String: AnyObject]]) -> [TableViewRow] {
		// Rows map
		var _rows: [TableViewRow] = []
		
		//Loop with data received
		for item in data {
			_rows.append(TableViewRow(data: item))
		}
		
		return _rows
	}
	
	fileprivate func _addSection(_ data: [[String: AnyObject]], tag: String = "", type: SectionType = .unknow) -> TableViewSection {
		//Remove preload before add any section
		self._removePreload()
		
		//Remove empties before add any section
		self._removeEmpty()
		
		var _rows = self._processRowsData(data)
		var _type = type
		
		if _rows.isEmpty {
			_rows = self._processRowsData([])
			_type = .empty
		}
		
		let _section: TableViewSection = TableViewSection(rows: _rows, tag: tag, type: _type)
		self._sections.append(_section)
		
		//Reload table view data after fill section
		self._tableViewReloadData()
		
		return _section
	}
	
	//Remove preload
	fileprivate func _removePreload() {
		guard self._preloadItems > 0 else {return}
		guard self._sections.first != nil else {return}
		
		if self._sections.first!.type == .preload {
			self._sections.removeFirst()
		}
		
	}
	
	//Remove empties
	fileprivate func _removeEmpty() {
		guard self._sections.last != nil else {return}
		
		if self._sections.last!.type == .empty {
			self._sections.removeLast()
		}
	}
	
	// MARK: - Public functions
	
	open func addSection(_ data: [[String: AnyObject]], tag: String = "") -> TableViewSection {
		var _data: [[String: AnyObject]] = data
		if data.count == 0 {
			_data = []
		}
		
		let _section = self._addSection(_data, tag: tag, type: .content)
		
		return _section
	}
	
	open func addSectionScrollingToEnd(_ data: [[String: AnyObject]], tag: String = "") {
		//Add Section
		let _section = self.addSection(data, tag: tag)
		
		//Scrolling to end
		let _rowEndIndex = _section.rows.endIndex - 1
		let _sectionEndIndex = self._sections.endIndex - 1
		let indexPath = IndexPath(row: _rowEndIndex, section: _sectionEndIndex)
		if let _tableView = self.delegate?.getTableView() {
			_tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
		}else{
			print("Missing tableViewManager")
		}
	}
	
	// Fill the _section with preload data
	open func addPreload() {
		guard self._preloadItems > 0 else { return }
		
		self.clear()
		
		var _rows = [TableViewRow]()
		for _ in 1...self._preloadItems {
            _rows.append(TableViewRow(data: [:]))
		}
		
		let _section: TableViewSection = TableViewSection(rows: _rows, tag: "preload", type: .preload)
		
		self._sections.append(_section)
		
		//Reload table view data after fill section
		self._tableViewReloadData()
	}
	
	open func clear() {
		guard !self._sections.isEmpty else {return}
		
		self.currentPage = 1
		
		self._sections = [TableViewSection]()
	}
	
	open func clearKeepingFirst() {
		guard !self._sections.isEmpty else {return}
		guard self._sections.count >= 1 else {return}
		
		let _firstSection = self._sections.first
		self.clear()
		self._sections.append(_firstSection!)
	}
	
	open func sectionType(_ section: Int) -> SectionType {
		guard !self._sections.isEmpty else {return SectionType.unknow}
		
		return self._sections[section].type
	}
	
	open func sectionTag(_ section: Int) -> String {
		guard !self._sections.isEmpty else {return ""}
		
		return self._sections[section].tag
	}
	
	open func get(_ indexPath: IndexPath) -> TableViewRow {
        guard !self._sections.isEmpty && !self._sections[(indexPath as NSIndexPath).section].rows.isEmpty else { return TableViewRow(data: [:]) }
		
		return self._sections[(indexPath as NSIndexPath).section].rows[(indexPath as NSIndexPath).row]
	}
	
	open func remove(_ indexPath: IndexPath) {
		guard !self._sections.isEmpty && !self._sections[(indexPath as NSIndexPath).section].rows.isEmpty else {return}
		
		self._sections[(indexPath as NSIndexPath).section].rows.remove(at: (indexPath as NSIndexPath).row)
	}
	
	//Total of sections
	open func total() -> Int {
		return self._sections.count
	}
	
	//Total of rows in specific section
	open func total(_ section: Int) -> Int {
		guard self._sections[section].type != SectionType.empty else {
			return 1
		}
        
		return self._sections[section].rows.count
	}
	
}
