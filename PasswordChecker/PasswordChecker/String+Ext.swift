//
//  String+Ext.swift
//  OrigonHub
//
//  Created by GEORGE QUENTIN on 31/08/2020.
//  Copyright © 2020 GEORGE QUENTIN. All rights reserved.
//
import Foundation

extension String {
    
    // MARK: - Localization
    
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

}
