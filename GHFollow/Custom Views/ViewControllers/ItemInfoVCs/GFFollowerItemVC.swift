//
//  GFFollowerItemVC.swift
//  GHFollow
//
//  Created by Saul Rivera on 29/06/20.
//  Copyright © 2020 Saul Rivera. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "The user has no followers. What a shame 🤩.", buttonTitle: "So sad")
            return
        }
        delegate?.didTapGetFollowers(for: user)
    }
}
