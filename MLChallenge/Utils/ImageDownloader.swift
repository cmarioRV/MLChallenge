//
//  ImageDownloader.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import UIKit

class ImageDownloader {
    func downloadImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if error == nil, let data = data, let image = UIImage(data: data) {
                    completion(image, nil)
                }
                else {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
