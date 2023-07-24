//
//  ButtonModifier.swift
//  OasisStore
//
//  Created by Vanara Leng on 7/6/23.
//

import SwiftUI

struct ToolbarButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(12)
            .foregroundColor(.white)
            .font(Font.system(size: 20))
    }
}

struct MainButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(isEnabled ? Color.accentColor :  Color.disableTextColor)
            .foregroundColor(.white)
            .cornerRadius(6)
            .font(.body.bold())
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.bold())
            .padding(8)
            .background(Color.white)
            .foregroundColor(isEnabled ? .accentColor : .disableTextColor)
            .cornerRadius(8)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.accentColor, lineWidth: 1)
            }
            
    }
}
