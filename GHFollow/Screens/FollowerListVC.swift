//
//  FollowerListVC.swift
//  GHFollow
//
//  Created by Saul Rivera on 27/06/20.
//  Copyright © 2020 Saul Rivera. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section { case main }
    
    var username: String!
    var page = 1
    var hasMoreFollowers = true
    var followers: [Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
        getFollowers(username, in: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func getFollowers(_ username: String, in page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, in: page) { [weak self] result in
            guard let self = self else { return }
            self.dissmisLoadingView()
            
            switch result {
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
                DispatchQueue.main.async { self.navigationController?.popViewController(animated: true) }
            case .success(let followers):
                if followers.count < 99 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😔."
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                self.updateData()
            }
        }
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout(in: self.view))
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.delegate = self
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username, in: page)
        }
    }
}
