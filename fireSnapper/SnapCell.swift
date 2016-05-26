//
//  SnapTableCell.swift
//  snapSaver
//
//  Created by Eric Torigian on 5/14/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase

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
		snapName.text = snap.snapName
		snapDetails.text = snap.snapDesc
		snapTags.text = snap.snapTags
		
		if snap.imageURL != nil {
			DataService.ds.REF_STORAGE.storage.referenceForURL(snap.imageURL!).dataWithMaxSize(INT64_MAX){ (data, error) in
				if let error = error {
					print("error downloading file \(error)")
					return
				}
				
				self.snapImage.image = UIImage(data: data!)
			}
		}
		
	}
	
}
