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

public class TableViewCell: UITableViewCell {
	public var row: TableViewRow?
	public var indexPath: NSIndexPath?
	public var delegate: TableViewCellDelegate?
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	public func updateViewData(){}
	
	override public func prepareForReuse() {
		super.prepareForReuse()
	}
}