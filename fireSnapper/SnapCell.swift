//
//  SnapTableCell.swift
//  snapSaver
//
//  Created by Eric Torigian on 5/14/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class SnapCell: UITableViewCell {
	@IBOutlet weak var snapName: UILabel!
	@IBOutlet weak var snapImage: UIImageView!
	@IBOutlet weak var snapTags: UILabel!
	@IBOutlet weak var snapDetails: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		snapImage.layer.cornerRadius = 20.0
		snapImage.clipsToBounds = true
	}
	
	func configureCell(snap: Snap) {
		snapName.text = snap.name
		snapImage.image = snap.getSnapImg()
		snapDetails.text = snap.details
		snapTags.text = snap.tags
		
	}
}
