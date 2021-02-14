//
//  UIImageViewExtension.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 14/2/21.
//

import UIKit

extension UIImageView {
    /// Download image from url
    ///
    /// - Parameter url: Url where image is located
    /// - Returns:       Image in task data response
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    /// Download image from string
    ///
    /// - Parameter link: String where image is located
    /// - Returns:        Image in task data response
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
