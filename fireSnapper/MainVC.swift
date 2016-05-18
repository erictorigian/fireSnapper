//
//  MainVC.swift
//  fireSnapper
//
//  Created by Eric Torigian on 5/17/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	
	
	//MARK: - View lifecycle functions

	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
        tableView.rowHeight = 121
	}
	
	override func viewDidAppear(animated: Bool) {
		let UID = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
		print("UID: \(UID)")
	}
	
	
	//MARK: - Tableview funtions
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3;
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		return tableView.dequeueReusableCellWithIdentifier("SnapCell") as! SnapCell
	}
	
}