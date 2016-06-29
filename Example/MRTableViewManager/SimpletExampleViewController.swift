//
//  ViewController.swift
//  MRTableViewManager
//
//  Created by Marcelo Reis on 06/25/2016.
//  Copyright (c) 2016 Marcelo Reis. All rights reserved.
//
import UIKit
import MRTableViewManager
import SwiftyJSON

// MARK: - Life Cycle
final class SimpleExampleViewController: UITableViewController {
	// MARK: - Attributes
	
	// Privates
	private let _tableViewManager:TableViewManager = TableViewManager()
	
	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// TableViewManager Delegate
		self._tableViewManager.delegate = self
		
		//Update tableView data
		self._updateTableView()
	}
	
	func refreshTableView(){
		self._tableViewManager.clear()
		self._updateTableView()
	}
	
	// MARK: - Private functions
	private func _updateTableView(){
		//Add section with feed data
		Serializer.jsonFromUrl(
			"https://raw.githubusercontent.com/marceloreis13/MRTableViewManager/master/foobars.txt",
			completionHandler: { data in
				let _json = JSON(data)
				self._tableViewManager.addSection(_json["foobars"])
			},
			errorHandler: { error in
				NSLog("\(error)")
			}
		)
	}
}

// MARK: TableViewManagerDelegate
extension SimpleExampleViewController: TableViewManagerDelegate {
	func getTableView() -> UITableView {
		return self.tableView
	}
	
	func next(callback: (TableViewManager.Callback)?) {
		self._tableViewManager.currentPage += 1
		self._updateTableView()
	}
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SimpleExampleViewController {
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return self._tableViewManager.total()
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self._tableViewManager.total(section)
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let _cell = tableView.dequeueReusableCellWithIdentifier("labelCell", forIndexPath: indexPath)
		let _foo = self._tableViewManager.get(indexPath)
		var _rowContent:String = ""
		if let _character = _foo.data["character"].string {
			_rowContent = "\(_character)"
		}
		
		_cell.textLabel?.text = _rowContent
		
		return _cell
	}	
}