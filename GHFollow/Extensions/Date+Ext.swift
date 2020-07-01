//
//  Date+Ext.swift
//  GHFollow
//
//  Created by Saul Rivera on 29/06/20.
//  Copyright © 2020 Saul Rivera. All rights reserved.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
