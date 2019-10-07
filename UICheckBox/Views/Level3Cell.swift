//
//  Level3Cell.swift
//  UICheckBox
//
//  Created by Greg Delgado on 10/7/19.
//  Copyright © 2019 Greg Delgado. All rights reserved.
//

import UIKit

class Level3Cell: UITableViewCell {
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var checkbox: UICheckBox = {
        return UICheckBox()
    }()
    
    var topVerticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var bottomVerticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var horizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var levelTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        return label
    }()
    
    var levelDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        return label
    }()
    
    var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16.0
        return stackView
    }()
    
    var showBottomVerticalLine = true {
        didSet {
            bottomVerticalLine.isHidden = !showBottomVerticalLine
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
    
    func setupView() {
        selectionStyle = .none
        contentView.backgroundColor = .gray
        contentView.addSubview(containerView)
        
        containerView.backgroundColor = .black
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(checkbox)
        stackView.addArrangedSubview(levelTitleLabel)
        containerView.addSubview(levelDescriptionLabel)
        containerView.addSubview(topVerticalLine)
        containerView.addSubview(bottomVerticalLine)
        containerView.addSubview(horizontalLine)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        setupContainerConstraints()
        setupTopVerticalLineConstraints()
        setupBottomVerticalLineConstraints()
        setupHorizontalLineConstraints()
        setupStackViewConstraints()
        setupDescriptionLabelConstraints()
    }
    
    func setupContainerConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }
    
    func setupTopVerticalLineConstraints() {
        topVerticalLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topVerticalLine.widthAnchor.constraint(equalToConstant: 3.0),
            topVerticalLine.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32.0),
            topVerticalLine.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0),
        ])
        let heightConstraint = topVerticalLine.heightAnchor.constraint(equalToConstant: 35.0)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
    }
    
    func setupBottomVerticalLineConstraints() {
        bottomVerticalLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomVerticalLine.widthAnchor.constraint(equalToConstant: 3.0),
            bottomVerticalLine.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32.0),
            bottomVerticalLine.topAnchor.constraint(equalTo: topVerticalLine.bottomAnchor, constant: 0.0),
            bottomVerticalLine.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0.0),
        ])
        let heightConstraint = bottomVerticalLine.heightAnchor.constraint(equalToConstant: 45.0)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
    }
    
    func setupHorizontalLineConstraints() {
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalLine.heightAnchor.constraint(equalToConstant: 3.0),
            horizontalLine.widthAnchor.constraint(equalToConstant: 16.0),
            horizontalLine.leftAnchor.constraint(equalTo: topVerticalLine.rightAnchor, constant: 0.0),
            horizontalLine.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32.0)
        ])
    }

    func setupStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkbox.heightAnchor.constraint(equalToConstant: 36.0),
            checkbox.widthAnchor.constraint(equalToConstant: 36.0),
            stackView.leftAnchor.constraint(equalTo: horizontalLine.rightAnchor, constant: -4.0),
            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: horizontalLine.centerYAnchor),
        ])
    }
    
    func setupDescriptionLabelConstraints() {
        levelDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            levelDescriptionLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0.0),
            levelDescriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16.0),
            levelDescriptionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16.0),
        ])
    }
    
    func configure(with row: Row) {
        self.row = row
        levelTitleLabel.text = row.title
        levelDescriptionLabel.text = row.subTitle
        showBottomVerticalLine = row.showsTail
        checkbox.setCheckState(row.checkState)
    }
}

extension Level3Cell: NodeSelectable {
    var node: Node {
        return row.node
    }
}
