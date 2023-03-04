//
//  ImageLoadViewModel.swift
//  concurrency-test
//
//  Created by 서채희 on 2023/03/05.
//

import UIKit

class ImageLoadViewModel {
    var urlList = ["https://picsum.photos/id/10/200/300",
                   "https://picsum.photos/id/11/200/300",
                   "https://picsum.photos/id/12/200/300",
                   "https://picsum.photos/id/13/200/300",
                   "https://picsum.photos/id/14/200/300"]
    
    func getUrlListCount() -> Int {
        return urlList.count
    }
    
    func loadAllImages(in collectionView: UICollectionView) {
        for i in 0 ..< self.getUrlListCount() {
            guard let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? ImageLoadCell else {
                return
            }
            cell.setImage(withUrl: self.urlList[i])
        }
    }
}
