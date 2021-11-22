//
//  ViewController.swift
//  Week8-2
//
//  Created by Mehmet Salih ÇELİK on 17.11.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var firstPhotoNameTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    var photoList = PhotosViewModel(photos: [])
    var photoURL = ""
    var searchURL = ""
    var textFieldList = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureContents()
    }
    
    private func configureContents() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    private func appendTextFieldList(textFieldText: String?) {
        guard let temp = textFieldText else { return }
        guard temp.isEmpty else { return textFieldList.append(temp) }
    }

    private func appendSearchURL(text: String) {
        searchURL = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Constants.apiKey)&text=\(text))&format=json&nojsoncallback=1"
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        photoURL.removeAll()
        textFieldList.removeAll()
        appendTextFieldList(textFieldText: firstPhotoNameTextField.text)
        guard textFieldList.isEmpty == false else { return }
        appendSearchURL(text: textFieldList)
        Webservice.downloadModel(searchURL) { success in
            self.photoList.photos = success
            self.photoCollectionView.reloadData()
        }
    }
    
}

extension ViewController: UICollectionViewDelegate { }

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.photoList.getPhotosCount ?? 0
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
