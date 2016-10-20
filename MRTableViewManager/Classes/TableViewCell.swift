//
//  TableViewCell.swift
//  Pods
//
//  Created by Marcelo Reis on 6/21/16.
//
//

import UIKit

public protocol TableViewCellDelegate {
	//    func deleteRow(indexPath: NSIndexPath)
}

open class TableViewCell: UITableViewCell {
	open var row: TableViewRow?
	open var indexPath: IndexPath?
	open var delegate: TableViewCellDelegate?
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	open func updateViewData() {}
	
	override open func prepareForReuse() {
		super.prepareForReuse()
	}
}
