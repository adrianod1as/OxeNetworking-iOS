//
//  MoyaDispatcher.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 21/07/20.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

public protocol MoyaDispatcher: Dispatcher {

    var resultHandler: ResultHandler { get }
    var errorFilter: ErrorFilter { get }
    var interceptor: RequestInterceptor { get }
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: Alamofire.Session { get }
    var provider: MoyaProvider<MultiTarget> { get }
    init(environment: Environment, resultHandler: ResultHandler ,
         errorFilter: ErrorFilter, interceptor: RequestInterceptor)
    func getMock(from endpoint: TargetType) -> Response?
    func handle(originalResult: MoyaResult, completion: @escaping Completion)
}

public extension MoyaDispatcher {

    var sessionConfiguration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        //        configuration.httpMaximumConnectionsPerHost = 1
        configuration.requestCachePolicy = environment.cachePolicy
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        return configuration
    }

    var session: Alamofire.Session {
        let session = Session(configuration: sessionConfiguration, interceptor: interceptor,
                              serverTrustManager: environment.serverTrustManager)
        return session
    }

    var provider: MoyaProvider<MultiTarget> {
        let endpointClosure = { (target: MultiTarget) -> Endpoint in
            return Endpoint.from(target: target, inEnvironment: self.environment)
        }
        let provider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, session: session)
        return provider
    }

    func call(endpoint: TargetType, completion: @escaping Completion) {
        standardlyCall(endpoint: endpoint, completion: completion)
    }

    func handle(originalResult: MoyaResult, completion: @escaping Completion) {
        standardlyHandle(originalResult: originalResult, completion: completion)
    }
}

extension MoyaDispatcher {

    func standardlyCall(endpoint: TargetType, completion: @escaping Completion) {
        if let response = getMock(from: endpoint) {
            completion(.success(response))
            return
        }
        provider.request(endpoint.asMultiTarget) { originalResult in
            self.handle(originalResult: originalResult, completion: completion)
        }
    }

    func standardlyHandle(originalResult: MoyaResult, completion: @escaping Completion) {
        let filteredResult = errorFilter.filterForErrors(in: originalResult.result)
        self.session.setSharedCookies(for: filteredResult.success?.response?.url)
        let response = originalResult.success ?? originalResult.failure?.response
        let error = filteredResult.failure?.underlyingError
        self.resultHandler.handleRequest(response: response, error: error) { _ in
            completion(filteredResult)
        }
    }
}
