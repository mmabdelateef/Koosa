//
//  KoosaTests.swift
//  KoosaTests
//
//  Created by Mostafa Abdellateef on 8/31/18.
//  Copyright © 2018 Mostafa Abdellateef. All rights reserved.
//

import XCTest
@testable import Koosa

class KoosaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        
        GroupAdminUser.shouldBeAbleTo(DeleteGroup.action).when {
            guard let groupAdmin = $0 as? GroupAdminUser,
                let deleteAction = $1 as? DeleteGroup else { return false }
            return groupAdmin.groupNumber == deleteAction.group.groupNumber
        }
        
        GroupMemberUser.shouldBeAbleTo(BrowseGroup.action).when {
            guard let groupMember = $0 as? GroupMemberUser,
                let browseAction = $1 as? BrowseGroup else { return false }
            return groupMember.groupNumber == browseAction.group.groupNumber
        }
        
        Visitor.shouldBeAbleTo(BrowseGroup.action).when {
            guard let browseAction = $1 as? BrowseGroup else { return false }
            return browseAction.group.isPublicGroup
        }
        
        _ = SuperAdminUser.shouldBeAbleTo(BrowseGroup.action)
        _ = SuperAdminUser.shouldBeAbleTo(PostToGroup.action)
        _ = SuperAdminUser.shouldBeAbleTo(DeleteGroup.action)
        
        let group1 = Group(groupNumber: 1, isPublicGroup: false)
        let group2 = Group(groupNumber: 2, isPublicGroup: true)
        
        let visitor = Visitor()
        let member1 = GroupMemberUser(name: "member1", age: 18, groupNumber: 1)
        let member2 = GroupMemberUser(name: "member2", age: 22, groupNumber: 2)
        let admin1 = GroupAdminUser(name: "admin1", age: 18, groupNumber: 1)
        let admin2 = GroupAdminUser(name: "admin2", age: 22, groupNumber: 2)
        let superAdmin = SuperAdminUser(name: "SuperAdmin", age: 30)
        
        assert(member1.can(BrowseGroup(group: group1)))
        assert(!member2.can(BrowseGroup(group: group1)))
        assert(!visitor.can(BrowseGroup(group: group1)))
        assert(visitor.can(BrowseGroup(group: group2)))
        assert(!visitor.can(DeleteGroup(group: group1)))
        assert(admin1.can(DeleteGroup(group: group1)))
        assert(!admin1.can(DeleteGroup(group: group2)))
        assert(!admin2.can(DeleteGroup(group: group1)))
        assert(admin2.can(DeleteGroup(group: group2)))
        assert(!superAdmin.can(DeleteGroup(group: group2)))
    }
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


