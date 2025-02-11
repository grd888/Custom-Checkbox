//
//  Level2Cell.swift
//  UICheckBox
//
//  Created by Greg Delgado on 10/7/19.
//  Copyright © 2019 Greg Delgado. All rights reserved.
//

import UIKit

class Level2Cell: UITableViewCell {
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var checkbox: UICheckBox = {
        return UICheckBox()
    }()
    
    var verticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var levelTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 19.0, weight: .bold)
        return label
    }()
    
    var showTail = true {
        didSet {
            verticalLine.isHidden = !showTail
        }
    }
    
    var row: Row!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .none
        contentView.backgroundColor = .black
        contentView.addSubview(containerView)
        
        containerView.backgroundColor = UIColor.cellBackground
        containerView.addSubview(checkbox)
        containerView.addSubview(levelTitleLabel)
        containerView.addSubview(verticalLine)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupContainerConstraints()
        setupCheckboxContstraints()
        setupLabelConstraints()
        setupVerticalLineConstraints()
    }
    
    private func setupContainerConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
        ])
    }
    
    private func setupVerticalLineConstraints() {
        verticalLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalLine.widthAnchor.constraint(equalToConstant: 3.0),
            verticalLine.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32.0),
            verticalLine.topAnchor.constraint(equalTo: checkbox.bottomAnchor, constant: -4.0),
            verticalLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0),
        ])
    }
    
    private func setupCheckboxContstraints() {
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkbox.heightAnchor.constraint(equalToConstant: 36.0),
            checkbox.widthAnchor.constraint(equalToConstant: 36.0),
            checkbox.centerXAnchor.constraint(equalTo: verticalLine.centerXAnchor),
            checkbox.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
    
    private func setupLabelConstraints() {
        levelTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            levelTitleLabel.leftAnchor.constraint(equalTo: checkbox.rightAnchor, constant: 16.0),
            levelTitleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16.0),
            levelTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.0),
            levelTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16.0),
        ])
    }
    
    func configure(with row: Row) {
        self.row = row
        
        levelTitleLabel.text = row.title
        checkbox.setCheckState(row.checkState)
        showTail = row.showsTail
    }
}

extension Level2Cell: NodeSelectable {
    var node: Node {
        return row.node
    }
}
