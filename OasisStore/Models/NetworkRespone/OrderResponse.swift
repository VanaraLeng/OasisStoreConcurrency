//
//  OrderResponse.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/16/23.
//

import Foundation

struct OrderResponse: Decodable {
    let success: Bool
    let data: [Product]
}

