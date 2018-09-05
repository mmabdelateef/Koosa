//
//  Koosa.swift
//  Koosa
//
//  Created by Mostafa Abdellateef on 8/31/18.
//  Copyright © 2018 Mostafa Abdellateef. All rights reserved.
//

import Foundation

public protocol Action {
    init()
    static var action: Action.Type { get }
}

public extension Action {
    static var action: Action.Type { return Self.self }
}

public protocol Role {
    init()
    static func shouldBeAbleTo (_ action: Action.Type) -> Rule
    func can (_ action: Action) -> Bool
}

public extension Role {
    
    static func shouldBeAbleTo(_ action: Action.Type) -> Rule {
        let rule = Rule(action: action.init(), role: self.init())
        rule.condition = { role, action in
            
            guard role is Self else {
                return false
            }
            return true
        }
        rules.append(rule)
        return rule
    }
    
    func can (_ action: Action) -> Bool {
        return rules.reduce(false) {
            $1.apply(role: self, action: action) || $0
        }
    }
}

public class Rule {
    
    let action: Action
    let role: Role
    var condition: ((Role, Action) -> Bool)?
    
    init(action: Action, role: Role) {
        self.action = action
        self.role = role
    }
    
    func apply(role: Role, action: Action) -> Bool {
        return condition?(role, action) ?? false
    }
    
    public func when(condition: @escaping (Role, Action) -> Bool) {
        self.condition = condition
    }
}

internal var rules = [Rule]()
