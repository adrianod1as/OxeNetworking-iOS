//
//  Moya+Ext.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import Moya

public extension Endpoint {

    static func from(target: TargetType, inEnvironment environment: Environment) -> Endpoint {
        var httpHeaderFields = environment.commonHeaders
        if let multiTarget = target as? MultiTarget,
            let headersSpecifyable = multiTarget.target as? HigherLayerHeadersSpecifyable {
            for type in headersSpecifyable.specificHeaderTypes where environment.specificHeaders[type.key] != nil {
                httpHeaderFields?.merge(environment.specificHeaders[type.key]! ?? [:], uniquingKeysWith: { $1 })
            }
        }
        httpHeaderFields?.merge(target.headers ?? [:], uniquingKeysWith: { $1 })
        return Endpoint(url: (environment.baseURL ?? target.baseURL).appendingPathComponent(target.path).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: httpHeaderFields)
    }
}

public extension TargetType {

    var asMultiTarget: MultiTarget {
        return MultiTarget(self)
    }
}
