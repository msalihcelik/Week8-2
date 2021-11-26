//
//  ViewController.swift
//  Week8-2
//
//  Created by Mehmet Salih ÇELİK on 17.11.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    var photoList = PhotosViewModel(photos: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
    }
    
    private func configureContents() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        searchBar.delegate = self
    }
    
}

//MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return .init(top: 0, left: 16, bottom: 0, right: 16)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 16
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cellWidth = (collectionView.frame.width - (4 * 16)) / 3
            return .init(width: cellWidth, height: cellWidth)
        }
    
}

//MARK: - UICollectionViewDataSource Methods
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.photoList.getPhotosCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.photoCell, for: indexPath) as! CollectionViewCell
        //    https://live.staticflickr.com/{server-id}/{id}_{secret}_{size-suffix}.jpg
        let url = "https://live.staticflickr.com"
        let serverId = photoList.getServerId(indexPath: indexPath.row)
        let id = photoList.getId(indexPath: indexPath.row)
        let secret = photoList.getSecret(indexPath: indexPath.row)
        cell.imageView.configureKF(url: "\(url)/\(serverId)/\(id)_\(secret)_m.jpg")
        return cell
    }
    
}

//MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.lowercased() else { return }
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        guard let encodedText = encodedText else { return }
        WebService.getFlickrPhotos(text: encodedText) { success in
            self.photoList.photos = success
            self.photoCollectionView.reloadData()
        }
    }
    
}
