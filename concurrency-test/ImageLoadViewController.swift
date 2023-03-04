//
//  ImageLoadViewController.swift
//  concurrency-test
//
//  Created by 서채희 on 2023/03/05.
//

import UIKit

class ImageLoadViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = ImageLoadViewModel()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Button Action
    @IBAction func loadAllImagesButtonDidTap(_ sender: Any) {
        self.viewModel.loadAllImages(in: collectionView)
    }
}

// MARK: - CollectionView Setting
extension ImageLoadViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getUrlListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageLoadCell", for: indexPath) as? ImageLoadCell else {
            return UICollectionViewCell()
        }
        cell.loadHandler = {
            cell.setImage(withUrl: self.viewModel.urlList[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}
