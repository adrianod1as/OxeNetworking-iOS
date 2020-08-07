//
//  CommonMoyaDispatcher.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

open class CommonMoyaDispatcher: MoyaDispatcher {

    public var environment: Environment
    public let resultHandler: ResultHandler
    public let errorFilter: ErrorFilter
    public let interceptor: RequestInterceptor

    required public init(environment: Environment, resultHandler: ResultHandler,
                         errorFilter: ErrorFilter, interceptor: RequestInterceptor) {
        self.environment = environment
        self.resultHandler = resultHandler
        self.errorFilter = errorFilter
        self.interceptor = interceptor
    }

    open func call(endpoint: TargetType, completion: @escaping Completion) {
        standardlyCall(endpoint: endpoint, completion: completion)
    }

    open func handle(originalResult: MoyaResult, completion: @escaping Completion) {
        standardlyHandle(originalResult: originalResult, completion: completion)
    }

}
