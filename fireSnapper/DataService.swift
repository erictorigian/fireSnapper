//
//  DataService.swift
//  fireSnapper
//
//  Created by Eric Torigian on 5/17/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://firesnapper.firebaseio.com"

class DataService {
	static let ds = DataService()
    
	private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_SNAPS = Firebase(url: "\(URL_BASE)/snaps")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
	
	var REF_BASE: Firebase {
		return _REF_BASE
	}
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    var REF_SNAPS: Firebase {
        return _REF_SNAPS
    }
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
    
    
}
