//
//  SecondExampleTableViewController.swift
//  MRTableViewManager
//
//  Created by Marcelo Reis on 6/25/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import MRTableViewManager
import SwiftyJSON

class PreloadExampleTableViewController: UITableViewController, TableViewManagerDelegate {
	// MARK: - Attributes
	
	// Privates
	//You can insert how many preload items that you want, but by default is 1 item
	private let _tableViewManager:TableViewManager = TableViewManager(preloadItems: 3)
//	private let _tableViewManager:TableViewManager = TableViewManager()

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
		//Here, you can asign NIBs made by yourself, just alter this lines above
		self.tableView.registerNib(UINib(nibName: self.MRContentTVC, bundle: nil), forCellReuseIdentifier: self.MRContentTVC)
		self.tableView.registerNib(UINib(nibName: self.MREmptyTVC, bundle: nil), forCellReuseIdentifier: self.MREmptyTVC)
		self.tableView.registerNib(UINib(nibName: self.MRPreloadTVC, bundle: nil), forCellReuseIdentifier: self.MRPreloadTVC)
		
		//Auto Layout
		self.tableView.rowHeight = UITableViewAutomaticDimension
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
	
				// I put this sleep to force the preload appear in tableview
				sleep(5)
				
				let _json = JSON(data)
				self._tableViewManager.addSection(_json["foobars"])
			},
			errorHandler: { error in
				NSLog("\(error)")
			}
		)
	}

	// MARK: TableViewManager Delegate
	
	func getTableView() -> UITableView {
		return self.tableView
	}
	
	func next(callback: (TableViewManager.Callback)?) {
		self._tableViewManager.currentPage += 1
		self._updateTableView()
	}
	
	// MARK: TableView Delegate functions
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return self._tableViewManager.total()
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self._tableViewManager.total(section)
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var _cell:TableViewCell
		let _sectionType = self._tableViewManager.sectionType(indexPath.section)
		
		switch _sectionType {
		case .Empty:
			_cell = tableView.dequeueReusableCellWithIdentifier(MREmptyTableViewCell.storyboardId) as! MREmptyTableViewCell
		case .Preload:
			_cell = tableView.dequeueReusableCellWithIdentifier(MRPreloadTableViewCell.storyboardId) as! MRPreloadTableViewCell
		case .Content:
			_cell = tableView.dequeueReusableCellWithIdentifier(MRContentTableViewCell.storyboardId) as! MRContentTableViewCell
		case .Unknow:
			fatalError("Application requested for a non-existent item")
		}
		
		_cell.row = self._tableViewManager.get(indexPath)
		_cell.updateViewData()
		
		return _cell
	}
	
	override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 100
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}
