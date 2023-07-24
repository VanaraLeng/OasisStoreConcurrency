//
//  Product.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/15/23.
//

import Foundation

struct Product: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let description: String
    let imageUrl: String
    let price: Double
    let discount: Double
    let gallery: [String]?
}
