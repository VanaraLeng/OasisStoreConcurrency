//
//  GalleryView.swift
//  OasisStore
//
//  Created by Vanara Leng on 7/12/23.
//

import SwiftUI

struct GalleryView: View {
    
    @StateObject private var vm = GalleryViewModel()
    
    let columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 0) {
            
                ForEach(vm.images, id: \.self) { image in
                    Image(uiImage: image)
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .background(Color.green)
                }
            }
            
        }
        .background(Color.black)
        .ignoresSafeArea()
        .task {
            await vm.downloadImage()
        }
        
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
