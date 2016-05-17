//
//  LoginVC.swift
//  fireSnapper
//
//  Created by Eric Torigian on 5/17/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginVC: UIViewController {
	//MARK: - IBOutlets and variables
	@IBOutlet weak var emailField: MaterialTextField!
	@IBOutlet weak var passwordField: MaterialTextField!
	
	
	
	//MARK: - View lifecycle functions
	override func viewDidLoad() {
		super.viewDidLoad()

	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
			self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
		}
	}
	
	//MARK: - IBActions
	
	@IBAction func fbBtnPressed(sender: AnyObject) {
		let facebookLogin = FBSDKLoginManager()
		
		facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
			
			if facebookError != nil {
				print("Facebook login failed.  Error \(facebookError)")
			} else {
				let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
				print("successfully logged in with facebook. \(accessToken)")
				
				DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
					
					if error != nil {
						print("Login failed.  \(error.description)")
					} else {
						print("Logged in! \(authData)")
						NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
						self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
					}
					
				})
			}
		}

		
	}
	
}
