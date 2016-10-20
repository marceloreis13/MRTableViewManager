//
//  EmptyExampleTableViewController.swift
//  MRTableViewManager
//
//  Created by Marcelo Reis on 6/25/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import MRTableViewManager

// MARK: - Life Cycle
final class EmptyExampleTableViewController: UITableViewController {
	// MARK: - Attributes
	
	// Privates
	fileprivate let _tableViewManager:TableViewManager = TableViewManager()
	
	//XIBs
	private let MRContentTVC = "MRContentTableViewCell"
	private let MREmptyTVC = "MREmptyTableViewCell"
	private let MRPreloadTVC = "MRPreloadTableViewCell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// TableViewManager Delegate
		self._tableViewManager.delegate = self
		
		//Update tableView data
		self._updateTableView()
		
		// Register XIBs
		self.tableView.register(UINib(nibName: self.MRContentTVC, bundle: nil), forCellReuseIdentifier: self.MRContentTVC)
		self.tableView.register(UINib(nibName: self.MREmptyTVC, bundle: nil), forCellReuseIdentifier: self.MREmptyTVC)
		self.tableView.register(UINib(nibName: self.MRPreloadTVC, bundle: nil), forCellReuseIdentifier: self.MRPreloadTVC)
		
		//Auto Layout
		self.tableView.rowHeight = UITableViewAutomaticDimension
	}
	
	func refreshTableView(){
		self._tableViewManager.clear()
		self._updateTableView()
	}
	
	// MARK: - Private functions
	fileprivate func _updateTableView(){
		//Add section with a empty feed data
		let _ = self._tableViewManager.addSection([])
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

// MARK: - TableViewManager Delegate
extension EmptyExampleTableViewController: TableViewManagerDelegate {
	
	func getTableView() -> UITableView {
		return self.tableView
	}
	
	func next(_ callback: (TableViewManager.Callback)?) {
		self._tableViewManager.currentPage += 1
		self._updateTableView()
	}
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension EmptyExampleTableViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return self._tableViewManager.total()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self._tableViewManager.total(section)
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var _cell:TableViewCell
		let _sectionType = self._tableViewManager.sectionType(indexPath.section)
		
		switch _sectionType {
		case .empty:
			_cell = tableView.dequeueReusableCell(withIdentifier: MREmptyTableViewCell.storyboardId) as! MREmptyTableViewCell
		case .preload:
			_cell = tableView.dequeueReusableCell(withIdentifier: MRPreloadTableViewCell.storyboardId) as! MRPreloadTableViewCell
		case .content:
			_cell = tableView.dequeueReusableCell(withIdentifier: MRContentTableViewCell.storyboardId) as! MRContentTableViewCell
		case .unknow:
			fatalError("Application requested for a non-existent item")
		}
		
		_cell.row = self._tableViewManager.get(indexPath)
		_cell.updateViewData()
		
		return _cell
	}
    
	override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	
}
