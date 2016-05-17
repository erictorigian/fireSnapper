//
//  MaterialTextField.swift
//  fambam
//
//  Created by Eric Torigian on 4/11/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class MaterialTextField: UITextField {
	
	override func awakeFromNib() {
		layer.cornerRadius = 2.0
		layer.borderColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.1).CGColor
		layer.borderWidth = 1.0
	}
	
	
	//MARK:  Style placeholder
	override func textRectForBounds(bounds: CGRect) -> CGRect {
		return CGRectInset(bounds, 10, 0)
	}
	
	
	//MARK: Stye edit
	override func editingRectForBounds(bounds: CGRect) -> CGRect {
		return CGRectInset(bounds, 10, 0)
	}

}
