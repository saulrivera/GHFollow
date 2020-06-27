//
//  GFBodyLabel.swift
//  GHFollow
//
//  Created by Saul Rivera on 27/06/20.
//  Copyright © 2020 Saul Rivera. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(alignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = alignment
        
        configure()
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        self.font = .preferredFont(forTextStyle: .body)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
