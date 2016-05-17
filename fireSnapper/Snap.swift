//
//  Snap.swift
//  fireSnapper
//
//  Created by Eric Torigian on 5/17/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Foundation

class Snap {
	
	var image :NSData?
	var name: String?
	var details: String?
	var tags: String?
	
	func setSnapImage(img: UIImage) {
		let data = UIImagePNGRepresentation(img)
		self.image = data
	}
	
	func setSnapImageWithData(imgData: NSData) {
		self.image = imgData
	}
	
	
	func getSnapImg() -> UIImage {
		let img = UIImage(data: self.image!)!
		return img
	}

}
