//
//  Webservice.swift
//  Week8-2
//
//  Created by Mehmet Salih ÇELİK on 22.11.2021.
//

import Foundation
import Alamofire

class WebService {
    
    typealias CompletionHandler = (_ success: [Photo] ) -> Void
    
    static func getFlickrPhotos(text: String, completionHandler: @escaping CompletionHandler) {
        let searchURL = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Constants.apiKey)&text=\(text))&format=json&nojsoncallback=1"
        AF.request(searchURL, method: .post).response { response in
            switch (response.result) {
            case .success:
                let decoder = JSONDecoder()
                do {
                    guard let data = response.data else { return }
                    let decodedData = try decoder.decode(Photos.self, from: data)
                    completionHandler(decodedData.photos.photo)
                }
                catch {
                    print("fail")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
