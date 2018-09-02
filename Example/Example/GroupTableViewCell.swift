//
//  GroupTableViewCell.swift
//  Example
//
//  Created by Mostafa Abdellateef on 9/2/18.
//  Copyright © 2018 Mostafa Abdellateef. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var publicLabel: UILabel!
    @IBOutlet weak var browseBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postBtn.layer.cornerRadius = 3
        postBtn.clipsToBounds = true
        
        browseBtn.layer.cornerRadius = 3
        browseBtn.clipsToBounds = true
        
        deleteBtn.layer.cornerRadius = 3
        deleteBtn.clipsToBounds = true
    }
    
}
