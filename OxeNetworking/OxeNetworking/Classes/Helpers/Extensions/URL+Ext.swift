//
//  URL+Ext.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation

public extension URL {

    var sharedCookies: [HTTPCookie] {
        guard let sharedCookies = HTTPCookieStorage.shared.cookies(for: self) else {
            return []
        }
        return sharedCookies
    }
}
