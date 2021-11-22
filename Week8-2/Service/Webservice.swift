//
//  Webservice.swift
//  Week8-2
//
//  Created by Mehmet Salih ÇELİK on 22.11.2021.
//

import Foundation
import Alamofire

class Webservice {
    typealias CompletionHandler = (_ success: [Photo] ) -> Void
    
    static func downloadModel(_ searchURL: String, completionHandler: @escaping CompletionHandler) {
        AF.request(searchURL).response { response in
            guard response.error == nil else { return }
            guard let data = response.data else { return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(Photos.self, from: data)
                completionHandler(decodedData.photos.photo)
            }
            catch {
                print("fail")
            }
        }
    }
    
}
