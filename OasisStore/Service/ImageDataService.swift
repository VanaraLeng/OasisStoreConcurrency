//
//  ImageDataService.swift
//  OasisStore
//
//  Created by Vanara Leng on 7/12/23.
//

import UIKit

struct TestModel: Decodable {
    let name: String
}

class ImageDataService {

    func downloadImage() async throws -> UIImage  {
        let urlRequest = URLRequest(url: URL(string: "https://picsum.photos/200")!)
        do {
            let imageData = try await NetworkManager.shared.make(request: urlRequest)
            if let image = UIImage(data: imageData) {
                return image
            }
            
            throw NetworkError.unknown
        } catch {
            print(error)
            throw error
        }
    }
}
