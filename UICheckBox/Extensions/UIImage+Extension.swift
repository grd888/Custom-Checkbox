//
//  UIImage+Extension.swift
//  UICheckBox
//
//  Created by Greg Delgado on 10/7/19.
//  Copyright © 2019 Greg Delgado. All rights reserved.
//

import UIKit

extension UIImage {
    enum Icons {
        enum Checkbox {
            static let selected = UIImage(named: "icon_checked")!
            static let unselected = UIImage(named: "icon_unchecked")!
            static let partialSelected = UIImage(named: "icon_indeterminate")!
        }
        enum Chevron {
            static let collapse = UIImage(named: "icon_arrow_collapse")!
            static let expand = UIImage(named: "icon_arrow_expand")!
        }
    }
}
