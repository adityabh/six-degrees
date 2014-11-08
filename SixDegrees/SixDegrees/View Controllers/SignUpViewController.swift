//
//  SignUpViewController.swift
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController : SDViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func signUpButtonTapped(sender: AnyObject) {

    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
}
    
