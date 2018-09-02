//
//  GroupsViewController.swift
//  Example
//
//  Created by Mostafa Abdellateef on 9/2/18.
//  Copyright © 2018 Mostafa Abdellateef. All rights reserved.
//

import UIKit
import Koosa


class GroupsViewController: UITableViewController {
    
    var user: Role?
    var username : String?
    
    let groups = [Group(groupNumber: 1, isPublicGroup: true),
                  Group(groupNumber: 2, isPublicGroup: false),
                  Group(groupNumber: 3, isPublicGroup: false),
                  Group(groupNumber: 4, isPublicGroup: true)]
    
    let users = [GroupMemberUser(name: "Group1Member", age: 18, groupNumber: 1),
                 GroupMemberUser(name: "Group2Member", age: 22, groupNumber: 2),
                 GroupAdminUser(name: "Group1Admin", age: 18, groupNumber: 1),
                 GroupAdminUser(name: "Group3Admin", age: 30, groupNumber: 3),
                 SuperAdminUser(name: "SuperAdmin", age: 30)]
    
    var allowedGroups: [Group] {
        user = users.filter { $0.name == username }.first as? Role ?? Visitor()
        return groups.filter { user?.can(BrowseGroup(group: $0)) ?? false }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupTableViewCell
        let group = allowedGroups[indexPath.row]
        cell.deleteBtn.isHidden = !(user?.can(DeleteGroup(group: group)) ?? false)
        cell.postBtn.isHidden = !(user?.can(PostToGroup(group: group)) ?? false)
        cell.publicLabel.isHidden = !group.isPublicGroup
        cell.groupNameLabel.text = "Group \(group.groupNumber)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allowedGroups.count
    }
}
