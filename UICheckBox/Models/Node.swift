//
//  Node.swift
//  UICheckBox
//
//  Created by Greg Delgado on 10/7/19.
//  Copyright © 2019 Greg Delgado. All rights reserved.
//

import Foundation

class Node: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    var title: String
    var children = [Node]()
    var state: CheckState = .unselected
    var subTitle: String?
    weak var parent: Node?
    var isLastNode: Bool = true
    var isActive = true
    
    var hasChildren: Bool {
        return !children.isEmpty
    }
    
    init(id: Int, title: String, children: [Node] = []) {
        self.id = id
        self.title = title
        self.children = children
        children.forEach{ $0.parent = self }
    }
    
    init(id: Int, title: String, subtitle: String, children: [Node] = [], isLastNode: Bool) {
        self.id = id
        self.title = title
        self.subTitle = subtitle
        self.children = children
        self.isLastNode = isLastNode
    }
    
    func toggle() {
        switch state {
        case .unselected, .partialSelected:
            state = .selected
        case .selected:
            state = .unselected
        }
        toggleChildren(state: state)
        parent?.childDidToggle()
    }
    
    func toggleState(_ state: CheckState) {
        toggleChildren(state: state)
    }
    
    func toggleChildren(state: CheckState) {
        for node in children {
            node.state = state
            node.toggleChildren(state: state)
        }
    }
    
    func childDidToggle() {
        updateStateFromChildren()
        parent?.childDidToggle()
    }
    
    func updateStateFromChildren() {
        if children.allSatisfy({ $0.state == .selected }) {
            state = .selected
        }
        else if children.allSatisfy({ $0.state == .unselected}) {
            state = .unselected
        }
        else {
            state = .partialSelected
        }
    }
    
    func getRoot() -> Node? {
        if parent == nil {
            return self
        }
        return parent?.getRoot()
    }
    
    func hasActiveChildren() -> Bool {
        let hasActive = children.contains(where: { $0.isActive })
        return hasActive
    }
}
