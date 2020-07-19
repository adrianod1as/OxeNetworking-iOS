//
//  GenericMoyaDispatcher.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

public class GenericMoyaDispatcher: Dispatcher {

    public var environment: Environment
    private let resultHandler: ResultHandler
    private let errorFilter: ErrorFilter
    private let interceptor: RequestInterceptor

    private lazy var sessionConfiguration: URLSessionConfiguration = {
        var configuration = URLSessionConfiguration.default
        //        configuration.httpMaximumConnectionsPerHost = 1
        configuration.requestCachePolicy = environment.cachePolicy
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        return configuration
    }()

    private lazy var session: Alamofire.Session = {
        let session = Session(configuration: sessionConfiguration, interceptor: interceptor,
                              serverTrustManager: environment.serverTrustManager)
        return session
    }()

    private lazy var provider: MoyaProvider<MultiTarget> = {
        let endpointClosure = { (target: MultiTarget) -> Endpoint in
            return Endpoint.from(target: target, inEnvironment: self.environment)
        }
        let provider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, session: session)
        return provider
    }()

    public init(environment: Environment, resultHandler: ResultHandler,
                errorFilter: ErrorFilter, interceptor: RequestInterceptor) {
        self.environment = environment
        self.resultHandler = resultHandler
        self.errorFilter = errorFilter
        self.interceptor = interceptor
    }

    open func call(endpoint: TargetType, completion: @escaping Completion) {
        if let response = getMock(from: endpoint) {
            completion(.success(response))
            return
        }
        provider.request(endpoint.asMultiTarget) { originalResult in
            self.handle(originalResult: originalResult, completion: completion)
        }
    }

    open func handle(originalResult: MoyaResult, completion: @escaping Completion) {
        let filteredResult = errorFilter.filterForErrors(in: originalResult.asGenericMoyaDispatcherResult)
        self.session.setSharedCookies(for: filteredResult.success?.response?.url)
        let response = originalResult.success ?? originalResult.failure?.response
        let error = filteredResult.failure?.toAnyError.error
        self.resultHandler.handleRequest(response: response, error: error) { _ in
            completion(filteredResult)
        }
    }

}
