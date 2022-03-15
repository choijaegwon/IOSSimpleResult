//
//  PhotoCell.swift
//  PhotoGalleryApp
//
//  Created by Jae kwon Choi on 2022/01/03.
//

import UIKit
import PhotosUI

class PhotoCell: UICollectionViewCell {
    
    func loadImage(asset: PHAsset) {
        
        let imageManager = PHImageManager()
        let scale = UIScreen.main.scale
        let imageSize = CGSize(width: 150 * scale, height: 150 * scale)
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        
        self.photoImageView.image = nil
        
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: options) {
            image, info in
            self.photoImageView.image = image
        }
        
    }
    
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet{
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    
    
}
