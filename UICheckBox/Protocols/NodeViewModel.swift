//
//  NodeViewModel.swift
//  UICheckBox
//
//  Created by Greg Delgado on 10/7/19.
//  Copyright © 2019 Greg Delgado. All rights reserved.
//

import Foundation

protocol NodeViewModel {
    var title: String { get set }
    var state: CheckState { get set }
    var subTitle: String? { get set }
}
