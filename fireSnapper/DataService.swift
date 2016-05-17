//
//  DataService.swift
//  fireSnapper
//
//  Created by Eric Torigian on 5/17/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import Foundation
import Firebase

class DataService {
	static let ds = DataService()
	
	private var _REF_BASE = Firebase(url: "firesnapper.firebaseio.com")
	
	var REF_BASE: Firebase {
		return _REF_BASE
	}
}
