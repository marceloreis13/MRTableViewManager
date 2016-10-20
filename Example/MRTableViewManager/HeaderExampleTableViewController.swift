//
//  HeaderExampleTableViewController.swift
//  MRTableViewManager
//
//  Created by Marcelo Reis on 6/27/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//
import UIKit
import MRTableViewManager

// MARK: Life Cycle
final class HeaderExampleViewController: UITableViewController {
    // MARK: - Attributes
    
    // Privates
    fileprivate let _tableViewManager:TableViewManager = TableViewManager()
    
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
            url: "https://raw.githubusercontent.com/marceloreis13/MRTableViewManager/master/foobars-header.txt",
            completionHandler: { data in
				if let _characters: NSDictionary = data["foobars"] as? NSDictionary {
                    if let _visitors: [[String:AnyObject]] = _characters["visitors"] as? [[String:AnyObject]] {
						let _ = self._tableViewManager.addSection(_visitors, tag: "Visitors")
					}
					if let _warriors: [[String:AnyObject]] = _characters["warriors"] as? [[String:AnyObject]] {
						let _ = self._tableViewManager.addSection(_warriors, tag: "Warrios")
					}
					if let _wizards: [[String:AnyObject]] = _characters["wizards"] as? [[String:AnyObject]] {
						let _ = self._tableViewManager.addSection(_wizards, tag: "Wizards")
					}
					if let _hobbits: [[String:AnyObject]] = _characters["hobbits"] as? [[String:AnyObject]] {
						let _ = self._tableViewManager.addSection(_hobbits, tag: "Hobbits")
					}
				}
				
            },
            errorHandler: { error in
                NSLog("\(error)")
            }
        )
    }
}


// MARK: - TableViewManagerDelegate
extension HeaderExampleViewController: TableViewManagerDelegate {
	func getTableView() -> UITableView {
		return self.tableView
	}
	
	func next(_ callback: (TableViewManager.Callback)?) {
		self._tableViewManager.currentPage += 1
		self._updateTableView()
	}
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HeaderExampleViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return self._tableViewManager.total()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self._tableViewManager.total(section)
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return self._tableViewManager.sectionTag(section);
	}
    
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let _cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath)
		let _foo = self._tableViewManager.get(indexPath as IndexPath)
		var _rowContent:String = ""
		if let _character = _foo.data["character"] as? String {
			_rowContent = "\(_character)"
		}
		
		_cell.textLabel?.text = _rowContent
		
		return _cell
	}
}
