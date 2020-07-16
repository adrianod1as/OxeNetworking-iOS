//
//  Alamofire+Ext.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import Alamofire

public extension Session {

    func setSharedCookies(for url: URL?) {
        guard let sharedCookies = url?.sharedCookies else {
            return
        }
        session.configuration.httpCookieStorage?.setCookies(sharedCookies, for: url, mainDocumentURL: nil)
    }
}
