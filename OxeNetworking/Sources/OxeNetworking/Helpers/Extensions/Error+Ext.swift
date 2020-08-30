//
//  Error+Ext.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import Moya
import Alamofire

extension Error {

    public var isTimeOut: Bool {
        return self._code == NSURLErrorTimedOut
    }
}

public extension MoyaError {

    var underlyingError: Swift.Error? {
        switch self {
        case .objectMapping(let error, _):
            return error
        case .encodableMapping(let error):
            return error
        case .statusCode: return nil
        case .underlying(let error, _):
            return error
        case .parameterEncoding(let error):
            return error
        default:
            return nil
        }
    }
}

