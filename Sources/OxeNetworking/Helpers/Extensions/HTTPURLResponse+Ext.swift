//
//  HTTPURLResponse+Ext.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation

public extension HTTPURLResponse {

    var isInformational: Bool {
        return (100...199).contains(statusCode)
    }

    var isSuccess: Bool {
        return (200...299).contains(statusCode)
    }

    var isRedirection: Bool {
        return (300...399).contains(statusCode)
    }

    var isClientError: Bool {
        return (400...499).contains(statusCode)
    }

    var isServerError: Bool {
        return (500...599).contains(statusCode)
    }
}
