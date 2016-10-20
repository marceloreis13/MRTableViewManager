//
//  ViewController.swift
//  MRTableViewManager
//
//  Created by Marcelo Reis on 06/25/2016.
//  Copyright (c) 2016 Marcelo Reis. All rights reserved.
//
import UIKit
import MRTableViewManager

// MARK: - Life Cycle
final class SimpleExampleViewController: UITableViewController {
	// MARK: - Attributes
	
	// Privates
	fileprivate let _tableViewManager:TableViewManager = TableViewManager()
	
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
	fileprivate func _updateTableView(){
		//Add section with feed data
		Serializer.jsonFromUrl(
			url: "https://raw.githubusercontent.com/marceloreis13/MRTableViewManager/master/foobars.txt",
			completionHandler: { data in
                if let _characters: [[String:AnyObject]] = data["foobars"] as? [[String:AnyObject]] {
					let _ = self._tableViewManager.addSection(_characters)
				}
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
	
	func next(_ callback: (TableViewManager.Callback)?) {
		self._tableViewManager.currentPage += 1
		self._updateTableView()
	}
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SimpleExampleViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return self._tableViewManager.total()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self._tableViewManager.total(section)
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let _cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath)
		let _foo = self._tableViewManager.get(indexPath)
		var _rowContent:String = ""
		if let _character = _foo.data["character"] as? String {
			_rowContent = "\(_character)"
		}
		
		_cell.textLabel?.text = _rowContent
		
		return _cell
	}	
}
