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
	
    
    //MARK: - Private class variables
    
	private var _imageURL :String?
	private var _snapName: String!
	private var _snapDesc: String!
	private var _snapTags: String!
    private var _snapKey: String!
	
    //MARK: - Public variables
    
    var snapName: String {
        return _snapName
    }
    
    var imageURL: String? {
        return _imageURL
    }
    
    var snapDesc: String {
        return _snapDesc
    }
    
    var snapTags: String {
        return _snapTags
    }
    
    var snapKey: String {
        return _snapKey
    }
    
    
    //MARK: - init
    
    init(name: String, snapDesc: String, tags: String, imageURL: String) {
        self._snapName = name
        self._snapDesc = snapDesc
        self._snapTags = tags
        self._imageURL = imageURL
    }
    
    init(snapKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._snapKey = snapKey
        if let name = dictionary["snapName"] as? String {
            self._snapName = name
        }
        
        if let snapDesc = dictionary["snapDesc"] as? String {
            self._snapDesc = snapDesc
        }
        
        if let tags = dictionary["snapTags"] as? String {
            self._snapTags = tags
        }
        
        if let imageURL = dictionary["imageURL"] as? String {
            self._imageURL = imageURL
        }
    }
    
    
    //MARK: - Getter/Setters
//	func setSnapImage(img: UIImage) {
//		let data = UIImagePNGRepresentation(img)
//		self.image = data
//	}
//	
//	func setSnapImageWithData(imgData: NSData) {
//		self.image = imgData
//	}
//	
//	
//	func getSnapImg() -> UIImage {
//		let img = UIImage(data: self.image!)!
//		return img
//	}

}
