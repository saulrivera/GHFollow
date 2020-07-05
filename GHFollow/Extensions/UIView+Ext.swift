//
//  UIView+Ext.swift
//  GHFollow
//
//  Created by Saul Rivera on 04/07/20.
//  Copyright © 2020 Saul Rivera. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
