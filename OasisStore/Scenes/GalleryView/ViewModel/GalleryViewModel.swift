//
//  GalleryViewModel.swift
//  OasisStore
//
//  Created by Vanara Leng on 7/24/23.
//

import SwiftUI

class GalleryViewModel: ObservableObject {
    
    private var dataService = ImageDataService()
    @Published var images = [UIImage]()
    
    @MainActor
    func downloadImage() async {
        try? await withThrowingTaskGroup(of: UIImage.self, body: { group in
            for _ in 0..<10 {
                group.addTask {
                    try await self.dataService.downloadImage()
                }
            }
            
            for try await image in group {
                self.images.append(image)
            }
        })
    }
}
