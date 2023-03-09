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
    @IBOutlet weak var progressView: UIProgressView!
    var loadHandler: (()->Void)?
    private var task: URLSessionDataTask?
    private var observation: NSKeyValueObservation!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.progressView.progress = 0
    }
    
    func setImage(withUrl url: URL) {
        observation = nil
        progressView.progress = 0
        
        self.imageView.image = UIImage(systemName: "photo")
        NetworkManager.shared.downloadImage(url: url, task: &task) { result in
            DispatchQueue.main.async {
                self.imageView.image = result.image
            }
        }
        
        // 진행도 옵저빙하여서 progress 표시
        observation = task?.progress.observe(\.fractionCompleted,
                                             options: [.new],
                                             changeHandler: { progress, change in
            DispatchQueue.main.async {
                self.progressView.progress = Float(progress.fractionCompleted)
            }
        })
    }
    
    @IBAction func loadButtonDidTap(_ sender: Any) {
        loadHandler?()
    }
}
