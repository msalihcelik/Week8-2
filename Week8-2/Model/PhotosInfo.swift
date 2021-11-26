//
//  PhotosInfo.swift
//  Week8-2
//
//  Created by Mehmet Salih ÇELİK on 19.11.2021.
//

struct PhotosInfo: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}
