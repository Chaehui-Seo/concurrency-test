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
    private var task: URLSessionDataTask?
    private var observation: NSKeyValueObservation!
    private var workItem: DispatchWorkItem!
    var loadHandler: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadButton.setTitle("Stop", for: .selected)
        loadButton.setTitle("Load", for: .normal)
        loadButton.isSelected = false
        progressView.progress = 0
    }
    
    func reset() {
        DispatchQueue.main.async {
            self.imageView.image = UIImage(systemName: "photo")
            self.progressView.progress = 0
            self.loadButton.isSelected = false
        }
    }
    
    func setImage(withUrl url: URL) {
        loadButton.isSelected = true
        progressView.progress = 0
        imageView.image = UIImage(systemName: "photo")
        
        workItem = DispatchWorkItem {
            NetworkManager.shared.downloadImage(url: url, task: &self.task) { image in
                // 로드 완료 후, 작업 취소 여부 확인 진행하고, UI 표시
                guard self.workItem.isCancelled == false else {
                    self.reset()
                    return
                }
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.loadButton.isSelected = false
                }
            } failHandler: {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(systemName: "xmark")
                }
            } cancelHandler: {
                self.reset()
            }
            
            // 진행도 옵저빙하여서 progress 표시
            self.observation = self.task?.progress.observe(\.fractionCompleted,
                                                 options: [.new],
                                                 changeHandler: { progress, change in
                guard self.workItem.isCancelled == false else {
                    self.observation.invalidate()
                    self.observation = nil
                    self.reset()
                    return
                }
                DispatchQueue.main.async {
                    self.progressView.progress = Float(progress.fractionCompleted)
                }
            })
        }
        
        DispatchQueue.global().async(execute: workItem)
    }
    
    @IBAction func loadButtonDidTap(_ sender: Any) {
        loadButton.isSelected = !loadButton.isSelected
        guard loadButton.isSelected else {
            self.workItem.cancel()
            return
        }
        loadHandler?()
    }
}
