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
	
	var img = UIImage(named: "camera")
	
	private var _REF_BASE = FIRDatabase.database().reference()
    private var _REF_SNAPS = FIRDatabase.database().referenceWithPath("/snaps")
    private var _REF_USERS = FIRDatabase.database().referenceWithPath("users")
	private var _REF_STORAGE = FIRStorage.storage().reference()
	
	var REF_BASE: FIRDatabaseReference {
		return _REF_BASE
	}
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_SNAPS: FIRDatabaseReference {
        return _REF_SNAPS
    }
	
	var REF_STORAGE: FIRStorageReference {
		return _REF_STORAGE
	}
    
    func createFirebaseUser(uid: String, userDetails: Dictionary<String, AnyObject>) {
		REF_USERS.child(uid).setValue(userDetails)
    }
	
			
}
