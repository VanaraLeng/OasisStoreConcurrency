//
//  BannerView.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/16/23.
//

import SwiftUI

struct BannerView: View {
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    var images: [String]
    
    @State var tabSelection = 0
    
    var banners: [Banner] {
        var banners: [Banner] = []
        for (index, image) in images.enumerated() {
            banners.append(Banner(id: index, image: image))
        }
        return banners
    }
    
    var body: some View {
        VStack(alignment: .center) {
            banner
            bannerIndicator
        }
        .onReceive(timer) { timer in
            if tabSelection + 1 >= banners.count {
                tabSelection = 0
            } else {
                tabSelection += 1
            }
        }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView(images: dev.banners)
            .previewLayout(.sizeThatFits)
    }
}

extension BannerView {
    
    var banner: some View {
        TabView (selection: $tabSelection) {
            ForEach(banners) { banner in
                AsyncImage(
                    url: URL(string: banner.image),
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            
                    },
                    placeholder: { ProgressView() }
                )
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeOut(duration: 0.4), value: tabSelection)
    }
    
    var bannerIndicator: some View {
        HStack(alignment: .center, spacing: 6) {
            ForEach(banners) { banner in
                Circle()
                    .fill(banner.id == self.tabSelection ?
                          Color.accentColor : Color.backgroundColor)
                    .frame(width: 10, height: 10)
            }
            
        }
        .padding()
    }
}
