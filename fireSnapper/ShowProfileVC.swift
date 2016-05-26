//
//  ShowProfileVC.swift
//  fireSnapper
//
//  Created by Eric Torigian on 5/19/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase

class ShowProfileVC: UIViewController {

	//MARK: - IBAOutlets
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var authProviderLabel: UILabel!
	@IBOutlet weak var userIdLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	
	//MARK: - IBActions
	@IBAction func logoutBtnPressed(sender: AnyObject) {
		try! FIRAuth.auth()!.signOut()
		let loginVC: UIViewController? = self.storyboard!.instantiateViewControllerWithIdentifier("Login")
		
		self.presentViewController(loginVC!, animated: true, completion: nil)
		
	}
	
	
	@IBAction func doneBtnPressed(sender: AnyObject) {
		
		
	}
	
	//MARK: - viewlife cycle functions
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		if let user = FIRAuth.auth()?.currentUser {
			nameLabel.text = user.displayName
			emailLabel.text = user.email
			userIdLabel.text = user.uid
			authProviderLabel.text = user.providerID
		}
	}
}
