//
//  ProductServiceProtocol.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/16/23.
//

import Foundation
import Combine

protocol ProductServiceProtocol {
    func getHomeData() async throws -> HomeResponse?
}
