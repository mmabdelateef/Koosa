//
//  ViewController.swift
//  Example
//
//  Created by Mostafa Abdellateef on 9/2/18.
//  Copyright © 2018 Mostafa Abdellateef. All rights reserved.
//

import UIKit
import Koosa

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let groupsVC = segue.destination as? GroupsViewController {
            groupsVC.username = usernameTextField.text
        }
    }
}
