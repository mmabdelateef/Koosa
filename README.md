# Koosa
Attributed Role-based Access Control For Swift (WIP)

## Usage

<table>
  <tr>
    <th width="50%">Here's an example</th>
    <th width="50%">In Action</th>
  </tr>
  <tr>
    <td/>
    <th rowspan="100"><img src="https://media.giphy.com/media/dYGhmIvkDHlvSxsWum/giphy.gif"></th>
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
