//
//  GFDataLoadingVC.swift
//  GHFollow
//
//  Created by Saul Rivera on 04/07/20.
//  Copyright © 2020 Saul Rivera. All rights reserved.
//

import UIKit

class GFDataLoadingVC: UIViewController {
    private var containerView: UIView!
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicatior = UIActivityIndicatorView(style: .large)
        activityIndicatior.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicatior)
        
        NSLayoutConstraint.activate([
            activityIndicatior.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicatior.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicatior.startAnimating()
    }
    
    func dissmisLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
