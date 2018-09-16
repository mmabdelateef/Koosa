# Koosa&nbsp;&nbsp;&nbsp;[![Build Status](https://travis-ci.org/mmabdelateef/Koosa.svg?branch=master)](https://travis-ci.org/mmabdelateef/Koosa) [![Coverage Status](https://coveralls.io/repos/github/mmabdelateef/Koosa/badge.svg?branch=master)](https://coveralls.io/github/mmabdelateef/Koosa?branch=master)
A simple Attributed Role-based Access Control For Swift
#### Check out this blog post for full explanation and more details: [Access Control Management with Swift](https://github.com/joemccann/dillinger/blob/master/KUBERNETES.md)

## Example

<table>
  <tr>
    <th width="50%">Code</th>
    <th width="50%">In Action</th>
  </tr>
  <tr>
    <td/>
    <th rowspan="20"><img src="https://media.giphy.com/media/dYGhmIvkDHlvSxsWum/giphy.gif"></th>
  </tr>
  <tr>
    <td><div class="highlight highlight-source-swift"><pre>
    
    // Anyone can browse group, if it is public
    Visitor.shouldBeAbleTo(BrowseGroup.action).when {
        guard let browseAction = $1 as? BrowseGroup else { return false }
        return browseAction.group.isPublicGroup
    }
    
    // Member can browse his groups + public groups
    GroupMemberUser.shouldBeAbleTo(BrowseGroup.action).when {
        guard let groupMember = $0 as? GroupMember,
            let browseAction = $1 as? BrowseGroup else { return false }
        return groupMember.groupNumber == browseAction.group.groupNumber
    }
    
    // Member can post his groups 
    GroupMemberUser.shouldBeAbleTo(PostToGroup.action).when {
        guard let groupMember = $0 as? GroupMember,
            let postAction = $1 as? PostToGroup else { return false }
        return groupMember.groupNumber == postAction.group.groupNumber
    }
    
    // Admin class extends Member + ability to delete
    GroupAdminUser.shouldBeAbleTo(DeleteGroup.action).when {
        guard let groupAdmin = $0 as? GroupAdmin,
            let deleteAction = $1 as? DeleteGroup else { return false }
        return groupAdmin.groupNumber == deleteAction.group.groupNumber
    }
    
    // SuperAdmin can do everything
    _ = SuperAdminUser.shouldBeAbleTo(BrowseGroup.action)
    _ = SuperAdminUser.shouldBeAbleTo(DeleteGroup.action)
    _ = SuperAdminUser.shouldBeAbleTo(PostToGroup.action)
    
</pre></div></td>
  </tr>
</table>

## Usage:

1. Start by mapping each role in your requirements to a protocl that extends to prtocol `Role` or a protocl that extends it. Note that you can model role heirarchy using protocl inheritance.
```swift
protocol GroupMember: Role {
    var groupNumber: Int {set get}
}
protocol GroupAdmin: GroupMember { }
```

2. Model your actions into classes/strcut that conforms to protocl `Action`.
```swift
struct BrowseGroup: Action {
    let group: Group
    
    init() {  // required default initializer
        group = Group(groupNumber: -1, isPublicGroup: false) // default froup
    }
    
    init(group: Group) {
        self.group = group
    }
}
```
3. Use role protocls to create concrete role classes.
```swift
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
```
4. Add the policies.
```swift
GroupMemberUser.shouldBeAbleTo(BrowseGroup.action).when {
    guard let groupMember = $0 as? GroupMember,
        let browseAction = $1 as? BrowseGroup else { return false }
    return groupMember.groupNumber == browseAction.group.groupNumber
}
GroupAdminUser.shouldBeAbleTo(DeleteGroup.action).when {
    guard let groupAdmin = $0 as? GroupAdminUser,
        let deleteAction = $1 as? DeleteGroup else {
            return false
    }
    return groupAdmin.groupNumber == deleteAction.group.groupNumber
}
_ = SuperAdminUser.shouldBeAbleTo(BrowseGroup.action)
```
5. Now you can validate if any user can do any action.
```swift
let member1 = GroupMemberUser(name: "member1", age: 18, groupNumber: 1)
let admin2 = GroupAdminUser(name: "admin2", age: 22, groupNumber: 2)
let group1 = Group(groupNumber: 1, isPublicGroup: false)
let group2 = Group(groupNumber: 2, isPublicGroup: false)
member1.can(BrowseGroup(group: group1) // true
member1.can(BrowseGroup(group: group2) // false
admin2.can(BrowseGroup(group: group1) // true: GroupAdmin inherits BrowseGroup permission from GroupMember
admin2.can(DeleteGroup(group: group2) // true
admin2.can(DeleteGroup(group: group1) // false
```

## Installation

Koosa can be installed using CocoaPods
```sh
use_frameworks!
pod 'Koosa'
```

License
----

MIT
