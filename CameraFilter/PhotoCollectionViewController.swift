//
//  PhotoCollectionViewController.swift
//  CameraFilter
//
//  Created by Konstantin Babushkin on 15.11.2022.
//

import UIKit
import Photos



class PhotoCollectionViewController: UICollectionViewController {

    private var images = [PHAsset] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populatePhotos()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    private func populatePhotos(){
        PHPhotoLibrary.requestAuthorization{ [weak self] status in
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                    
                }
                self?.images.reverse()
                self?.collectionView.reloadData()
            }
            
        }
    }
    
    
}
