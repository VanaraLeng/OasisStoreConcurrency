//
//  HomeViewModel.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var newProducts: [Product] = []
    @Published var popularProducts: [Product] = []
    @Published var banners: [String] = []
    
    @Published var isLoading = false
    
    @Published var errorString: String?
    @Published var showError = false
    @Published var isLogout = false
    
    private var dataService: ProductServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(dataService: ProductServiceProtocol) {
        self.dataService = dataService
        isLogout = KeychainUtil.shared.retrieve(service: .accessToken) != nil
    }
    
    @MainActor
    func fetchHomeData() async {
        Task {
            isLoading = true
            
            do {
                guard let response = try await dataService.getHomeData() else { return }
                if response.success == true {
                    newProducts = response.data.newProducts
                    popularProducts = response.data.popularProducts
                    banners = response.data.banners
                    
                } else {
                    errorString = response.message
                    showError = true
                }
                
            } catch {
                errorString = error.localizedDescription
                showError = true
               
            }
            isLoading = false
        }
    }
    
    func logout() {
        KeychainUtil.shared.delete(service: .accessToken)
        KeychainUtil.shared.delete(service: .refreshToken)
        isLogout = true
    }
}
