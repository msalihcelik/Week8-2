//
//  UIImageView+Extensions.swift
//  Week8-2
//
//  Created by Mehmet Salih ÇELİK on 19.11.2021.
//

import Foundation
import Kingfisher

extension UIImageView {
    func configureKF(url: String) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: url), placeholder: nil, options: [.transition(.fade(0.7 ))], progressBlock: nil)
    }
}
