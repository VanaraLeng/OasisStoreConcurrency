//
//  SideMenuView.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import SwiftUI

enum SideMenu: Int {
    case home
    case showCase
    case order
    case setting
    case logout
}

struct SideMenuView: View {
    
    @Binding var showSideMenu: Bool
    var onSelectMenu: (SideMenu) -> Void
    
    var menu: [Menu] = [
        Menu(id: SideMenu.home.rawValue, title: "home", icon: "house"),
        Menu(id: SideMenu.showCase.rawValue, title: "new_products", icon: "square.grid.2x2"),
        Menu(id: SideMenu.order.rawValue, title: "order", icon: "cart"),
        Menu(id: SideMenu.setting.rawValue, title: "setting", icon: "gear"),
        Menu(id: SideMenu.logout.rawValue, title: "log_out", icon: "rectangle.portrait.and.arrow.right", style: .destructive)
    ]
    
    private let title = String(localized: "app_name")
    private let footer = "Vanara Leng 2023"
    private let animationDuration = 0.3
    
    var body: some View {
        ZStack (alignment: .leading) {
            if showSideMenu {
                chromeView
                sideMenu
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(showSideMenu: .constant(true)) { menu in
            
        }
    }
}

extension SideMenuView {
    
    fileprivate var chromeView: some View {
        Color.black.opacity(0.8)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                withAnimation(.spring(response: animationDuration)) {
                    showSideMenu.toggle()
                }
            }
            .transition(.opacity)
    }
    
    fileprivate var sideMenu: some View {
        VStack {
            // Title
            Text(title)
                .font(.headline)
                .padding(.top, 10)
                .padding(.bottom, 0)
            
            // Menu here
            VStack {
                ForEach(menu) { menu in
                    MenuItemView(menu: menu)
                        .onTapGesture {
                            
                            withAnimation(.spring(response: animationDuration)) {
                                showSideMenu = false
                            }
                            
                            onSelectMenu(SideMenu(rawValue: menu.id) ?? .home)
                        }
                }
            }
            
            Spacer()
            
            Text (footer)
                .font(.footnote)
                .foregroundColor(.accentColor)
        }
        .background(
            Color.backgroundColor
                .ignoresSafeArea()
                .shadow(color: .shadowColor, radius: 5)
        )
        .frame(width: 300)
        .transition(.move(edge: showSideMenu ? .leading : .trailing))
    }
}
