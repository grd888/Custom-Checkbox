//
//  HeaderView.swift
//  UICheckBox
//
//  Created by Greg Delgado on 10/7/19.
//  Copyright © 2019 Greg Delgado. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: NSObject {
    func didSelectNode(_ node: Node)
}

class HeaderView: UIView {
    var checkbox: UICheckBox = {
       return UICheckBox()
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 19.0)
        return label
    }()
    
    var node: Node!
    var delegate: HeaderViewDelegate?

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .black
        addSubview(checkbox)
        addSubview(titleLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        gesture.cancelsTouchesInView = true
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
        setupConstraints()
    }
    

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        delegate?.didSelectNode(node)
    }
    
    func setupConstraints() {
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            checkbox.heightAnchor.constraint(equalToConstant: 36.0),
            checkbox.widthAnchor.constraint(equalToConstant: 36.0),
            checkbox.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            checkbox.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: checkbox.rightAnchor, constant: 16.0),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
            
            
        ])
    }
    
    func configure(with section: Section) {
        node = section.node
        titleLabel.text = section.title
        checkbox.setCheckState(section.checkState)
    }
    
    private func animateArrow(_ view: UIView, expand: Bool) {
        let transform = expand ? CGAffineTransform(rotationAngle: CGFloat(Double.pi)) : CGAffineTransform.identity
        UIView.animate(withDuration: 0.5) {
            view.transform = transform
        }
    }
}
