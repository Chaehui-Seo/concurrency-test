//
//  ImageLoadCell.swift
//  concurrency-test
//
//  Created by 서채희 on 2023/03/05.
//

import UIKit

class ImageLoadCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadButton: UIButton!
    var loadHandler: (()->Void)?
    
    func setImage(withUrl urlString: String) {
        self.imageView.image = UIImage(systemName: "photo")
        self.imageView.loadImage(with: urlString)
    }
    
    @IBAction func loadButtonDidTap(_ sender: Any) {
        loadHandler?()
    }
}
