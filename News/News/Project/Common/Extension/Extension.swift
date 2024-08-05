//
//  Extension.swift
//  News
//
//  Created by Phạm Thanh Hải on 5/8/24.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from urlString: String, into imageView: UIImageView) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        // Create a data task to fetch the image data
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to decode image data")
                return
            }

            // Update the UIImageView on the main thread
            DispatchQueue.main.async {
                imageView.image = image
            }
        }

        task.resume()
    }
}

