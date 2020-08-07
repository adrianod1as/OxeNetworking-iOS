//
//  Numbers+Ext.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation

public extension NSNumber {

    var isBool: Bool {
        return CFBooleanGetTypeID() == CFGetTypeID(self)
    }

    var boolValueDescription: String {
        return boolValue ? "1" : "0"
    }

}
