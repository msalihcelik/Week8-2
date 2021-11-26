//
//  Photo.swift
//  Week8-2
//
//  Created by Mehmet Salih ÇELİK on 19.11.2021.
//

struct Photo: Decodable {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int
    let title: String?
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
}
