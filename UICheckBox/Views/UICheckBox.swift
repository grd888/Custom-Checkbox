//
//  UICheckBox.swift
//  UICheckBox
//
//  Created by Greg Delgado on 10/7/19.
//  Copyright © 2019 Greg Delgado. All rights reserved.
//

import UIKit

class UICheckBox: UIImageView {

    private let selectedImage = UIImage.Icons.Checkbox.selected
        .withRenderingMode(.alwaysTemplate)
    
    private let unselectedImage = UIImage.Icons.Checkbox.unselected
        .withRenderingMode(.alwaysTemplate)
    
    private let partialSelectedImage = UIImage.Icons.Checkbox.partialSelected
        .withRenderingMode(.alwaysTemplate)
    
    var selectedColor: UIColor
    var unselectedColor: UIColor
    var partialSelectedColor: UIColor
    
    private var checkState: CheckState = .unselected
    
    func setCheckState(_ state: CheckState) {
        self.checkState = state
        updateState()
    }
    
    init(selectedColor: UIColor? = nil, unselectedColor: UIColor? = nil, partialSelectedColor: UIColor? = nil) {
        self.selectedColor = selectedColor ?? UIColor.checkBoxSelected
        self.unselectedColor = unselectedColor ?? UIColor.checkBoxUnSelected
        self.partialSelectedColor = partialSelectedColor ?? UIColor.checkBoxPartialSelected
        
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        contentMode = .scaleAspectFill
        updateState()
    }
    
    func updateState() {
        switch checkState {
        case .selected:
            image = selectedImage
            tintColor = selectedColor
        case .unselected:
            image = unselectedImage
            tintColor = unselectedColor
        case .partialSelected:
            image = partialSelectedImage
            tintColor = partialSelectedColor
        }
    }
    
}
