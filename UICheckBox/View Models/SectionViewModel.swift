//
//  SectionViewModel.swift
//  UICheckBox
//
//  Created by Greg Delgado on 10/7/19.
//  Copyright © 2019 Greg Delgado. All rights reserved.
//

import Foundation

struct SectionViewModel {
    var title: String
    var checkState: CheckState
    
    init(section: Section) {
        title = section.title
        checkState = section.checkState
    }
    
}
