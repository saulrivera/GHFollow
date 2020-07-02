//
//  FavoritesListVC.swift
//  GHFollow
//
//  Created by Saul Rivera on 26/06/20.
//  Copyright © 2020 Saul Rivera. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        
        PersistanceManager.retrieveFavorites { (result) in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                print(error)
            }
        }
    }

}
