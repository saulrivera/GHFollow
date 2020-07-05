//
//  GFAvatarImageView.swift
//  GHFollow
//
//  Created by Saul Rivera on 27/06/20.
//  Copyright © 2020 Saul Rivera. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let placeholderImage = Images.placeholderAvatar

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] (image) in
            guard let self = self, let image = image else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
