//
//  NewSnapVC.swift
//  fireSnapper
//
//  Created by Eric Torigian on 5/17/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Photos
import Firebase

class NewSnapVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	@IBOutlet weak var snapName: UITextField!
	@IBOutlet weak var snapDetails: UITextField!
	@IBOutlet weak var snapTags: UITextField!
	@IBOutlet weak var snapImage: UIImageView!
	@IBOutlet weak var addSnapButton: UIButton!
	
	var assets: PHFetchResult!
	var referenceUrl: NSURL!
	var imagePicked = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
//		imagePicker = UIImagePickerController()
//		imagePicker.delegate = self
		snapImage.layer.cornerRadius = 4.0
		snapImage.clipsToBounds = true

	}
	
	
	
	//MARK: - image picker functions
	
	@IBAction func addImage(sender: AnyObject) {
		
		let picker = UIImagePickerController()
		picker.delegate = self
//		if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
//			picker.sourceType = UIImagePickerControllerSourceType.Camera
//		} else {
//			picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//		}
		picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
		
		presentViewController(picker, animated: true, completion:nil)

		sender.setTitle("", forState: .Normal)
		
	}
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		picker.dismissViewControllerAnimated(true, completion: nil)
		
		self.referenceUrl = info[UIImagePickerControllerReferenceURL] as! NSURL
		self.assets = PHAsset.fetchAssetsWithALAssetURLs([referenceUrl], options: nil)
		snapImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
		imagePicked = true
		
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		picker.dismissViewControllerAnimated(true, completion:nil)
	}


	
	
	
	@IBAction func createSnap(sender: AnyObject) {
		
		if let txt = snapName.text where txt != "" {
			
			if imagePicked {
				let asset = self.assets.firstObject
				
				asset?.requestContentEditingInputWithOptions(nil, completionHandler: { (contentEditingInput, info) in
					let imageFile = contentEditingInput?.fullSizeImageURL
					let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\(Int(NSDate.timeIntervalSinceReferenceDate() * 1000))/\(self.referenceUrl.lastPathComponent!)"
					let metadata = FIRStorageMetadata()
					metadata.contentType = "image/jpeg"
					
					DataService.ds.REF_STORAGE.child(filePath)
						.putFile(imageFile!, metadata: metadata) { (metadata, error) in
							if let error = error {
								print("Error uploading: \(error.debugDescription)")
								return
							}
				
							//code the save to firebase here (image is already on the google bucket)
							self.postToFirebase(DataService.ds.REF_STORAGE.child((metadata?.path)!).description)
					}
					
				})
				
				
				
			} else {
				//no image picked
				self.postToFirebase(nil)
			}
		}
		
		
		}
	
	func postToFirebase(imgUrl: String?) {
		var snap: Dictionary<String, AnyObject> = [
			"snapName": snapName.text!,
			"snapDesc": snapDetails.text!,
			"snapTags": snapTags.text!
		]
		
		if imgUrl != nil {
			snap["imageURL"] = imgUrl!
		}
		
		let firebaseSnap = DataService.ds.REF_SNAPS.childByAutoId()
		firebaseSnap.setValue(snap)
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	

}
