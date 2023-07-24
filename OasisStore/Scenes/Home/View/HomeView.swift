//
//  ContentView.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HomeViewModel(dataService: ProductService())
    
    @State private var showSideMenu = false
    @State private var selectedProduct: Product?
    @State private var showDetail = false
    @State private var showOrder = false
    @State private var showCart = false
    @State private var showSetting = false
    @State private var showGallery = false
    
    private let springRespone = 0.2
    
    var body: some View {
        ZStack (alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 0) {
                headerView
                
                if !vm.showError && !vm.isLoading {
                    contentView
                }
                Spacer()
            }
         
            // Side menu
            SideMenuView(showSideMenu: $showSideMenu,
                         onSelectMenu: onMenuSelection
            )
        }
        .task {
            if vm.newProducts.isEmpty {
                await vm.fetchHomeData()
            }
        }
        .refreshable {
            await vm.fetchHomeData()
        }
        .navigationDestination(isPresented: $showDetail) {
            if showDetail,
               let selectedProduct = selectedProduct {
                ProductDetailView(product: selectedProduct)
            }
        }
        .navigationDestination(isPresented: $showGallery) {
            GalleryView()
        }
        .navigationDestination(isPresented: $showCart) {
            OrderCartView()
        }
        .navigationDestination(isPresented: $showOrder) {
            Text("Order View")
        }
        .navigationDestination(isPresented: $showSetting) {
            Text("Setting View")
        }
        
        .toolbarBackground(.hidden, for: .navigationBar)
        .alert(vm.errorString ?? "error_title", isPresented: $vm.showError) {
            Button("retry", role: .cancel) {
                Task {
                    await vm.fetchHomeData()
                }
            }
        }
        .fullScreenCover(isPresented: $vm.isLogout) {
            LoginView()
        }
        
    }
    
    func onProductTap(product: Product) {
        selectedProduct = product
        showDetail = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.vm)
            
    }
}

extension HomeView {
    
    var headerView: some View {
        HStack {
            Button {
                withAnimation(.spring(response: springRespone)) {
                    showSideMenu.toggle()
                }
            } label: { Image(systemName: "sidebar.left") }
            .buttonStyle(ToolbarButtonStyle())

            Spacer()
            
            Text("home")
                .navigationTitleText()
            
            Spacer()
            
            Button {
                withAnimation(.spring(response: springRespone)) {
                    showCart.toggle()
                }
            } label: { Image(systemName: "cart.fill") }
            .buttonStyle(ToolbarButtonStyle())
            
        }
        .padding(.horizontal, 8)
        .frame(height: 50)
        .background(Color.accentColor)
    
    }
    
    var contentView: some View {
        ScrollView {
            
            BannerView(images: vm.banners)
                .frame(height: 250)
            
            VStack {
                ProductSectionView(title: "home_section_new",
                                   products: $vm.popularProducts,
                                   onItemTap: onProductTap)
                
                Spacer()
                
                ProductSectionView(title: "home_section_popular",
                                   products: $vm.newProducts,
                                   onItemTap: onProductTap)
            }
        }
    }
    
    func onMenuSelection(menu: SideMenu) {
        switch menu {
        case .order:
            showOrder.toggle()
            
        case .setting:
            showSetting.toggle()
            
        case .showCase:
            showGallery.toggle()
            
        case .logout:
            vm.logout()
            
        default: break
        }
    }
       
}
