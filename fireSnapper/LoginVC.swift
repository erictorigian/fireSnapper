//
//  LoginVC.swift
//  fireSnapper
//
//  Created by Eric Torigian on 5/17/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase
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
		
		if (FIRAuth.auth()?.currentUser) != nil {
			performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
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
				
				let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
				
				FIRAuth.auth()?.signInWithCredential(credential) { user,error in
					
					if error != nil {
						print("Login failed.  \(error!.description)")
					} else {
						let userDetails = ["provider": "facebook"]
						let uid = user!.uid
						DataService.ds.createFirebaseUser(uid, userDetails: userDetails)

						self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
					}
					
				}
			}
		}

		
	}
	
	@IBAction func attemptLogin(sender: UIButton! ) {
		
		if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {

			FIRAuth.auth()?.signInWithEmail(email, password: pwd, completion: { user, error in
				if error != nil {
					
					if error!.code == STATUS_ACCOUNT_NONEXISTS {
						
						FIRAuth.auth()?.createUserWithEmail(email, password: pwd, completion: {( user, error) in
							
							if error != nil {
								self.showErrorAlert("Could not create account", msg: "Problem creating account on server \(error!.description)")
							} else {
								FIRAuth.auth()?.signInWithEmail(email, password: pwd, completion: { user, err in

									let userDetails = ["provider": "email", "email": email ]
									let uid = user!.uid
									DataService.ds.createFirebaseUser(uid, userDetails: userDetails)
					
									self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
								})
							}
						})
					
					} else if error!.code == STATUS_INVALID_PWD {
						
						self.showErrorAlert("Error logging in", msg: "Invalid password/email combination.   Please try again")
					
					} else if error!.code == STATUS_INVALID_EMAIL {
						
						self.showErrorAlert("Error logging in", msg: "You did not enter a valid email.   Please try again")
						
					} else if error!.code == STATUS_ACCOUNT_DISABLED {
						
						self.showErrorAlert("Error logging in", msg: "Your account has been disabled.   Please contact the administrator for futher assistance")
						
					} else 	{
						
						self.showErrorAlert("Error logging in", msg: error!.description)
					}
					
				}  else {
					let userDetails = ["provider": "email", "email": email]
					let uid = user!.uid
					DataService.ds.createFirebaseUser(uid, userDetails: userDetails)

					self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
				}
			})
		}
	}
	

	
	
	//MARK: - Other functions
	
	func showErrorAlert(title: String, msg: String) {
		let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert )
		let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
		alert.addAction(action)
		presentViewController(alert, animated: true, completion: nil)
	}
	
	

}
