//
//  Menu.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import Foundation

struct Menu: Identifiable  {
    let id: Int
    let title: String.LocalizationValue
    let icon: String
    let style: MenuStyle
    
    enum MenuStyle {
        case normal
        case destructive
    }
    
    init(id: Int, title: String.LocalizationValue, icon: String, style: MenuStyle = .normal) {
        self.id = id
        self.title = title
        self.icon = icon
        self.style = style
    }
    
}
