//
//  File.swift
//  UICheckBox
//
//  Created by Greg Delgado on 10/7/19.
//  Copyright © 2019 Greg Delgado. All rights reserved.
//

import UIKit

class HomeViewModel {
    var data: Node!
    var sections = [Section]()
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func sectionData(forSection section: Int) -> Section {
        return sections[section]
    }
    
    func row(forIndexPath indexPath: IndexPath) -> Row {
        let section = sections[indexPath.section]
        let row = section.rows[indexPath.row]
        return row
    }
    
    var dataDidChange: (() -> Void)?
    
    init() {
        createData()
        
    }
    
    private func createData() {
        data = Node(id: 0, title: "Select All", children: [
            Node(id: 1, title: "PGAY7"),
            Node(id: 2, title: "81KRU"),
            Node(id: 3, title: "GTW70", children: [
                Node(id: 4, title: "item 1", subtitle: "1   DEF", isLastNode: false),
                Node(id: 5, title: "item 2", subtitle: "2   DEF", isLastNode: false),
                Node(id: 6, title: "item 3", subtitle: "3   DEF", isLastNode: true),
            ])
        ])
        updateTableData()
    }
    
    private func updateTableData() {
        var rows = [Row]()
        for level2node in data.children {
            let row = Row(node: level2node, level: .level2)
            rows.append(row)
            for level3Node in level2node.children {
                let row = Row(node: level3Node, level: .level3)
                rows.append(row)
            }
        }
        
        let section = Section(node: data, rows: rows)
        sections = [section]
    }
    
    func selectNode(_ node: Node) {
        node.toggle()
        updateTableData()
        dataDidChange?()
    }
    
    func collapseSection(for node: Node, isCollapsed: Bool) -> Int? {
        guard let sectionIndex = sections.firstIndex(where: { $0.node.id == node.id }) else {
            return nil
        }
        let section = sections[sectionIndex]
        if (isCollapsed) {
            section.rows = []
        } else {
            updateTableData()
        }
        section.isCollapsed = isCollapsed
        
        return sectionIndex
    }
}

class Section {
    var node: Node
    var rows = [Row]()
    var title: String
    var checkState: CheckState = .unselected
    var isCollapsed = false
    init(node: Node, rows: [Row]) {
        self.node = node
        self.title = node.title
        self.checkState = node.state
        self.rows = rows
    }
}

struct Row {
    var node: Node
    var checkState: CheckState
    var title: String
    var subTitle: String?
    var showsTail: Bool
    var level: Level
    var isExpanded = true
    
    init(node: Node, level: Level) {
        self.node = node
        self.checkState = node.state
        self.title = node.title
        self.subTitle = node.subTitle
        self.showsTail = node.hasChildren || !node.isLastNode
        self.level = level
    }
}

enum Level {
    case level1
    case level2
    case level3
}

