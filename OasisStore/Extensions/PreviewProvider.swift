//
//  DevPreview.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import SwiftUI


extension PreviewProvider {
    
    static var dev: DevPreview {
        return DevPreview()
    }
}

class DevPreview {
    let vm = HomeViewModel(dataService: ProductService())
    
    let products = [
        Product(id: 0,
                name: "Baby Stroller",
                description: "Alienware 34 Inch Monitor",
                imageUrl: "https://m.media-amazon.com/images/I/41G5jTFLKhL._MCnd_AC_.jpg",
                price: 10.11,
                discount: 0.05,
                gallery: [
                    "https://m.media-amazon.com/images/I/41G5jTFLKhL._MCnd_AC_.jpg",
                    "https://m.media-amazon.com/images/I/51Q6a+Cp-5S.jpg",
                    "https://m.media-amazon.com/images/I/51Q6a+Cp-5S.jpg",
                ]),
        Product(id: 1,
                name: "Alienware 34",
                description: "Alienware 34 Inch Monitor",
                imageUrl: "https://m.media-amazon.com/images/I/71tUEbgSbzL._AC_SY400_.jpg",
                price: 10.11,
                discount: 0,
                gallery: nil)
    ]
    let menu = Menu(id: 0, title: "Home", icon: "house.fill")
    
    let banners = [
        "https://fastly.picsum.photos/id/1063/600/300.jpg?hmac=i2tLmbSCXenelEoYKm10lPXWd5ogiDYiVkKiGRpj2Qo",
        "https://fastly.picsum.photos/id/280/600/300.jpg?hmac=pd038H772vWcny167x0EIoJAP0VH-Er3rwMndSa04LU"
    ]
}
