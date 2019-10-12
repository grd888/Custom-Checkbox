//
//  HeaderView.swift
//  UICheckBox
//
//  Created by Greg Delgado on 10/7/19.
//  Copyright © 2019 Greg Delgado. All rights reserved.
//

import UIKit

protocol NodeSelectionDelegate: NSObject {
    func didSelectNode(_ node: Node)
    func didCollapseSelection(_ node: Node, isCollapsed: Bool)
}

class HeaderView: UIView {
    var checkbox: UICheckBox = {
       return UICheckBox()
    }()
    
    var chevronImage: UIImageView = {
        let image = UIImage.Icons.Chevron.down
        var imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 19.0)
        return label
    }()
    
    var node: Node!
    var delegate: NodeSelectionDelegate?
    var isCollapsed = false {
        didSet {
            updateChevronImage()
        }
    }
    
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
        addSubview(chevronImage)
        
        chevronImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCollapseButtonTap)))
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        isUserInteractionEnabled = true
        
        setupConstraints()
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        delegate?.didSelectNode(node)
    }
    
    @objc func handleCollapseButtonTap(_ gesture: UITapGestureRecognizer) {
        let isCollapsed = !self.isCollapsed
        animateArrow(collapsed: isCollapsed) {[unowned self] _ in
            self.delegate?.didCollapseSelection(self.node, isCollapsed: isCollapsed)
        }
    }
    
    func setupConstraints() {
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkbox.heightAnchor.constraint(equalToConstant: 36.0),
            checkbox.widthAnchor.constraint(equalToConstant: 36.0),
            checkbox.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            checkbox.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: checkbox.rightAnchor, constant: 16.0),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
            
            chevronImage.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16.0),
            chevronImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
            chevronImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImage.widthAnchor.constraint(equalToConstant: 30),
            chevronImage.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configure(with section: Section) {
        node = section.node
        titleLabel.text = section.title
        isCollapsed = section.isCollapsed
        checkbox.setCheckState(section.checkState)
    }
    
    private func animateArrow(collapsed: Bool, completion: @escaping ((Bool)->Void)) {
        let transform = collapsed ? CGAffineTransform(rotationAngle: CGFloat(Double.pi)) : CGAffineTransform(rotationAngle: CGFloat(Double.pi) * 1.01)
        UIView.animate(withDuration: 0.5, animations: {
            self.chevronImage.transform = transform
        }, completion: completion)
    }
    
    private func updateChevronImage() {
        chevronImage.image = isCollapsed ? UIImage.Icons.Chevron.down : UIImage.Icons.Chevron.up
    }
}
