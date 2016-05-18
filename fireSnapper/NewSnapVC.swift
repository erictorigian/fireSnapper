//
//  NewSnapVC.swift
//  fireSnapper
//
//  Created by Eric Torigian on 5/17/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class NewSnapVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	@IBOutlet weak var snapName: UITextField!
	@IBOutlet weak var snapDetails: UITextField!
	@IBOutlet weak var snapTags: UITextField!
	@IBOutlet weak var snapImage: UIImageView!
	@IBOutlet weak var addSnapButton: UIButton!
	
	var imagePicker: UIImagePickerController!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		snapImage.layer.cornerRadius = 4.0
		snapImage.clipsToBounds = true
		
		
	}
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
		imagePicker.dismissViewControllerAnimated(true, completion: nil)
		snapImage.image = image
	}
	
	
	@IBAction func addImage(sender: AnyObject) {
		presentViewController(imagePicker, animated: true, completion: nil)
		sender.setTitle("", forState: .Normal)
		
	}
	
	@IBAction func createSnap(sender: AnyObject) {
	
	
	}
	
	
}
