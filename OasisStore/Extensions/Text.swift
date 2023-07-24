//
//  Text.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/21/23.
//

import SwiftUI

extension Text {
    
    func titleText() -> Self {
        font(.title)
    }
    
    func navigationTitleText() -> Self {
        font(.headline)
            .foregroundColor(.white)
    }
    
    func menuTitleText() -> Self {
        font(.headline)
    }
    
    func bodyText() -> Self {
        font(.body)
            .foregroundColor(.textColor)
    }
    
    func headline() -> Self {
        font(.headline)
    }
    
    func listGroupText() -> Self {
        font(.body)
            .foregroundColor(.accentColor)
    }
    
    func discountText() -> Self {
        font(.subheadline)
            .foregroundColor(Color.red)
    }
    
    func disableText() -> Self {
        font(.caption2)
            .foregroundColor(.disableTextColor)
    }
    
    func priceText() -> Self {
        font(.title3)
    }
    
}
