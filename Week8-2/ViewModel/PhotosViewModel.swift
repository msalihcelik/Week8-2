//
//  PhotosViewModel.swift
//  Week8-2
//
//  Created by Mehmet Salih ÇELİK on 19.11.2021.
//

struct PhotosViewModel {
    var photos: [Photo]
    
    var getPhotosCount: Int {
        return self.photos.count
    }

    func getServerId(indexPath: Int) -> String {
        return self.photos[indexPath].server ?? ""
    }

    func getId(indexPath: Int) -> String {
        return self.photos[indexPath].id ?? ""
    }

    func getSecret(indexPath: Int) -> String {
        return self.photos[indexPath].secret ?? ""
    }
    
}
