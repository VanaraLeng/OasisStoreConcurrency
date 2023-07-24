//
//  MenuItemView.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import SwiftUI

struct MenuItemView: View {
    @State var menu: Menu
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack (spacing: 16) {
                Image(systemName: menu.icon)
                
                Text(String(localized: menu.title) )
                    .menuTitleText()
            }
            .padding(.top, 8)
            .padding(.horizontal, 16)
            .foregroundColor(menu.style == .destructive ? Color.red : Color.textColor)
            
            Color.shadowColor.opacity(0.2)
                .frame(height: 1)
        }
        .background(Color.backgroundColor)
    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(menu: dev.menu)
            .previewLayout(.sizeThatFits)
    }
}
