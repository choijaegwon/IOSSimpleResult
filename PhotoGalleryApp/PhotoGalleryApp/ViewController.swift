//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by Jae kwon Choi on 2022/01/03.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {

    var fetchResuts: PHFetchResult<PHAsset>?
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photo Gallery App"
        makeNavigationItem()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 0.5, height: 200)
        
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        photoCollectionView.collectionViewLayout = layout
        
        photoCollectionView.dataSource = self
        
    }
    
    func makeNavigationItem() {
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle"), style: .done, target: self, action: #selector(checkPermission))
        //버튼 색
        photoItem.tintColor = .black.withAlphaComponent(0.7)
        
        self.navigationItem.rightBarButtonItem = photoItem
        
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refresh))
        
        self.navigationItem.leftBarButtonItem = refreshItem
        
        refreshItem.tintColor = .black.withAlphaComponent(0.7)
    }
    
    @objc func checkPermission() {
        if PHPhotoLibrary.authorizationStatus() == .authorized ||
            PHPhotoLibrary.authorizationStatus() == .limited {
            DispatchQueue.main.async {
                self.showGallery()
            }
        } else if PHPhotoLibrary.authorizationStatus() == .denied {
            DispatchQueue.main.async {
                self.showAuthoriztionDeniedAlert()
            }
        } else if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                self.checkPermission()
            }
        }
    }
    
    func showAuthoriztionDeniedAlert() {
        let alert = UIAlertController(title: "포토라이브러리 접근 권한을 활성화 해주세요", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "설정으로 가기", style: .default, handler: { action in
            
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // 갤러리에서 가져오기
    @objc func showGallery() {
        let library = PHPhotoLibrary.shared()
        
        var configuration = PHPickerConfiguration(photoLibrary: library)
        // 가져올수있는갯수
        configuration.selectionLimit = 10
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
        
        
    }
    
    @objc func refresh() {
        self.photoCollectionView.reloadData()
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResuts?.count ?? 0
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        if let asset = self.fetchResuts?[indexPath.row] {
            cell.loadImage(asset: asset)
        }
        
        return cell
    }
    
    
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        let identifiers = results.map {
            $0.assetIdentifier ?? ""
        }
        
        self.fetchResuts = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
        
        self.photoCollectionView.reloadData()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
