//
//  KoosaConfig.swift
//  Example
//
//  Created by Mostafa Abdellateef on 9/2/18.
//  Copyright © 2018 Mostafa Abdellateef. All rights reserved.
//

import Foundation
import Koosa

func configureKoosaRules() {
    
    GroupMemberUser.shouldBeAbleTo(BrowseGroup.action).when {
        guard let groupMember = $0 as? GroupMember,
            let browseAction = $1 as? BrowseGroup else { return false }
        return groupMember.groupNumber == browseAction.group.groupNumber
    }
    
    GroupMemberUser.shouldBeAbleTo(PostToGroup.action).when {
        guard let groupMember = $0 as? GroupMember,
            let postAction = $1 as? PostToGroup else { return false }
        return groupMember.groupNumber == postAction.group.groupNumber
    }

    // Admin inherits Member
    GroupAdminUser.shouldBeAbleTo(DeleteGroup.action).when {
        guard let groupAdmin = $0 as? GroupAdmin,
            let deleteAction = $1 as? DeleteGroup else { return false }
        return groupAdmin.groupNumber == deleteAction.group.groupNumber
    }

    Visitor.shouldBeAbleTo(BrowseGroup.action).when {
        guard let browseAction = $1 as? BrowseGroup else { return false }
        return browseAction.group.isPublicGroup
    }
    
    _ = SuperAdminUser.shouldBeAbleTo(BrowseGroup.action)
    _ = SuperAdminUser.shouldBeAbleTo(DeleteGroup.action)
    _ = SuperAdminUser.shouldBeAbleTo(PostToGroup.action)
}

protocol GroupMember: Role {
    var groupNumber: Int {set get}
}
protocol GroupAdmin: GroupMember { }
protocol SuperAdmin: Role { }


class User {
    var name: String?
    var age: Int?
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    init() {
        
    }
}

class VisitorUser: User { }
class GroupMemberUser: User, GroupMember {
    var groupNumber: Int
    init(name: String, age: Int, groupNumber: Int) {
        self.groupNumber = groupNumber
        super.init(name: name, age: age)
    }
    
    override required init() {
        self.groupNumber = -1
        super.init()
    }
    
}
class GroupAdminUser: User, GroupAdmin {
    var groupNumber: Int
    init(name: String, age: Int, groupNumber: Int) {
        self.groupNumber = groupNumber
        super.init(name: name, age: age)
    }
    
    override required init() {
        self.groupNumber = -1
        super.init()
    }
}

class SuperAdminUser: User, SuperAdmin {
    override required init() {
        super.init()
    }
    
    override init(name: String, age: Int) {
        super.init(name: name, age: age)
    }
}

class Visitor: Role {
    required init() {}
}

struct Group {
    let groupNumber: Int
    let isPublicGroup: Bool
}


struct BrowseGroup: Action {
    init() {
        group = Group(groupNumber: -1, isPublicGroup: false)
    }
    let group: Group
    
    init(group: Group) {
        self.group = group
    }
}

struct PostToGroup: Action {
    init() {
        group = Group(groupNumber: -1, isPublicGroup: false)
    }
    let group: Group
    
    init(group: Group) {
        self.group = group
    }
}

struct DeleteGroup: Action {
    init() {
        group = Group(groupNumber: -1, isPublicGroup: false)
    }
    let group: Group
    
    init(group: Group) {
        self.group = group
    }
}
