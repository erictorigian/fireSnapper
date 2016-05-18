//
//  MainVC.swift
//  fireSnapper
//
//  Created by Eric Torigian on 5/17/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
    
    var snaps = [Snap]()
	
	
	//MARK: - View lifecycle functions

	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
        tableView.rowHeight = 121
        
        DataService.ds.REF_SNAPS.observeEventType(.Value, withBlock: { snapshot in
            self.snaps = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for fbSnap in snapshots {
                    
                    if let snapDict = fbSnap.value as? Dictionary<String, AnyObject> {
                        let key = fbSnap.key
                        let snap = Snap(snapKey: key, dictionary: snapDict)
                        
                        self.snaps.append(snap)
                    }
                    
                }
            }
            
            
            self.tableView.reloadData()
        })
	}
	
	override func viewDidAppear(animated: Bool) {
    
	}
	
	
	//MARK: - Tableview funtions
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return snaps.count;
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let snap = snaps[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("SnapCell") as? SnapCell {
            cell.configureCell(snap)
            return cell
        } else {
            return SnapCell()
        }
    }


	
}