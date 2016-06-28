//
//  HeaderExampleTableViewController.swift
//  MRTableViewManager
//
//  Created by Marcelo Reis on 6/27/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//
import UIKit
import MRTableViewManager
import SwiftyJSON

class HeaderExampleViewController: UITableViewController, TableViewManagerDelegate, TableViewCellDelegate {
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
            "https://raw.githubusercontent.com/marceloreis13/MRTableViewManager/master/foobars-header.txt",
            completionHandler: { data in
                let _json = JSON(data)
                let _characters = _json["foobars"]
            
                self._tableViewManager.addSection(_characters["visitors"], tag: "Visitors")
                self._tableViewManager.addSection(_characters["warriors"], tag: "Warrios")
                self._tableViewManager.addSection(_characters["wizards"], tag: "Wizards")
                self._tableViewManager.addSection(_characters["hobbits"], tag: "Hobbits")
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
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self._tableViewManager.sectionTag(section);
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
