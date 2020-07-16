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
    public let requestHandler: RequestHandler
    public let errorFilter: ErrorFilter

    private lazy var sessionConfiguration: URLSessionConfiguration = {
        var configuration = URLSessionConfiguration.default
        //        configuration.httpMaximumConnectionsPerHost = 1
        configuration.requestCachePolicy = environment.cachePolicy
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        return configuration
    }()

    private lazy var session: Alamofire.Session = {
        let session = Session(configuration: sessionConfiguration, interceptor: requestHandler,
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

    public init(environment: Environment, requestHandler: RequestHandler, errorFilter: ErrorFilter) {
        self.environment = environment
        self.requestHandler = requestHandler
        self.errorFilter = errorFilter
    }

    open func call(endpoint: TargetType, completion: @escaping Completion) {
        if let response = getMock(from: endpoint) {
            completion(.success(response))
            return
        }
        provider.request(MultiTarget(endpoint)) { originalResult in
            let filteredResult = self.errorFilter.filterForErrors(in: originalResult)
            self.session.setSharedCookies(for: filteredResult.success?.response?.url)
            let response = originalResult.success ?? originalResult.failure?.response
            let error = filteredResult.failure?.toAnyError.error
            self.requestHandler.handleRequest(response: response, error: error) { _ in
                completion(filteredResult)
            }

        }
    }

}
