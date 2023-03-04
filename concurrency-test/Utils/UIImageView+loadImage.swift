//
//  UIImageView+loadImage.swift
//  concurrency-test
//
//  Created by 서채희 on 2023/03/05.
//

import UIKit

extension UIImageView {
    /// URL 문자열을 통해 이미지를 다운 받아서 ImageView에  표시하는 메소드
    func loadImage(with urlString: String) {
        DispatchQueue.global().async { [weak self] in
            if let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
