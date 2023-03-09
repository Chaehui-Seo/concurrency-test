//
//  ImageLoadViewModel.swift
//  concurrency-test
//
//  Created by 서채희 on 2023/03/05.
//

import UIKit

class ImageLoadViewModel {
    func getUrlListCount() -> Int {
        return ImageURL.count()
    }
    
    func loadAllImages(in collectionView: UICollectionView) {
        for i in 0 ..< self.getUrlListCount() {
            guard let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? ImageLoadCell else {
                return
            }
            cell.setImage(withUrl: ImageURL[i])
        }
    }
}
