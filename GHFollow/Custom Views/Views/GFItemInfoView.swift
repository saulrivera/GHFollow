//
//  GFItemInfoView.swift
//  GHFollow
//
//  Created by Saul Rivera on 29/06/20.
//  Copyright © 2020 Saul Rivera. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {
    let symboleImageView = UIImageView()
    let titleLabel = GFTitleLabel(alignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(alignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(symboleImageView, titleLabel, countLabel)
        
        symboleImageView.translatesAutoresizingMaskIntoConstraints = false
        symboleImageView.contentMode = .scaleAspectFill
        symboleImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symboleImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symboleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symboleImageView.widthAnchor.constraint(equalToConstant: 20),
            symboleImageView.heightAnchor.constraint(equalTo: symboleImageView.widthAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: symboleImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symboleImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            countLabel.topAnchor.constraint(equalTo: symboleImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, with count: Int) {
        switch itemInfoType {
        case .repos:
            symboleImageView.image = SFSymbols.repos
            titleLabel.text = "Public Repos"
        case .gists:
            symboleImageView.image = SFSymbols.gists
            titleLabel.text = "Public Gists"
        case .followers:
            symboleImageView.image = SFSymbols.followers
            titleLabel.text = "Followers"
        case .following:
            symboleImageView.image = SFSymbols.following
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
}
