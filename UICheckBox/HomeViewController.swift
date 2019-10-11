//
//  HomeViewController.swift
//  UICheckBox
//
//  Created by Greg Delgado on 10/7/19.
//  Copyright © 2019 Greg Delgado. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let checkbox = UICheckBox()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var viewModel: HomeViewModel!
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        viewModel.dataDidChange = { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = "UICheckBox"
        setupTableView()
        setupConstraints()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(Level2Cell.self, forCellReuseIdentifier: Level2Cell.reuseIdentifier)
        tableView.register(Level3Cell.self, forCellReuseIdentifier: Level3Cell.reuseIdentifier)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = viewModel.row(forIndexPath: indexPath)
        switch row.level {
        case .level2:
            return level2Cell(tableView: tableView, indexPath: indexPath, row: row)
        case .level3:
            return level3Cell(tableView: tableView, indexPath: indexPath, row: row)
        default:
            fatalError()
        }
    }
    
    func level2Cell(tableView: UITableView, indexPath: IndexPath, row: Row) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Level2Cell.reuseIdentifier, for: indexPath) as! Level2Cell
        cell.configure(with: row)
        return cell
    }
    
    func level3Cell(tableView: UITableView, indexPath: IndexPath, row: Row) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Level3Cell.reuseIdentifier, for: indexPath) as! Level3Cell
        cell.configure(with: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = viewModel.sectionData(forSection: section)
        let header = HeaderView()
        header.configure(with: section)
        header.delegate = self
        return header
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? NodeSelectable else {
            return
        }
        viewModel.selectNode(cell.node)
    }
}

extension HomeViewController: HeaderViewDelegate {
    func didSelectNode(_ node: Node) {
        viewModel.selectNode(node)
    }
    
    func didCollapseSelection(_ node: Node, isCollapsed: Bool) {
        if let sectionIndex = viewModel.collapseSection(for: node, isCollapsed: isCollapsed) {
            tableView.reloadSections(IndexSet(integer: sectionIndex), with: .automatic)
        }
    }
}

