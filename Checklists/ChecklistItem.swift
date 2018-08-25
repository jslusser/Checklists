//
//  ChecklistItem.swift
//  Checklists
//
//  Created by James Slusser on 8/24/18.
//  Copyright © 2018 James Slusser. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
         checked = !checked
    }
}
