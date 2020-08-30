//
//  Environment.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import Alamofire
import Moya

public class Environment {

    public let baseURL: URL?

    public let type: EnvironmentSpecifying

    public let name: String

    public var commonHeaders: Headers

    public let cachePolicy: URLRequest.CachePolicy

    public let fixturesType: FixtureTypeSpecifying

    public var specificHeaders: SpecificHeaders

    public var serverTrustManager: ServerTrustManager

    // Initialize a new Environment
    public init(type: EnvironmentSpecifying, baseURL: URL? = nil, name: String, fixturesType: FixtureTypeSpecifying,
                commonHeaders: Headers = [:], specificHeaders: SpecificHeaders = SpecificHeaders(),
                serverTrustManager: ServerTrustManager = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: [:]),
                cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData) {
        self.type = type
        self.name = name
        self.commonHeaders = commonHeaders
        self.cachePolicy = cachePolicy
        self.fixturesType = fixturesType
        self.baseURL = baseURL
        self.specificHeaders = specificHeaders
        self.serverTrustManager = serverTrustManager
    }

    public convenience init(type: EnvironmentSpecifying, baseURL: URL? = nil, name: String, fixturesType: FixtureTypeSpecifying,
                commonHeaders: Headers = [:], specificHeaders: SpecificHeaders = SpecificHeaders(),
                certificate: Certificate, cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData) {
        self.init(type: type, baseURL: baseURL, name: name, fixturesType: fixturesType,
                  commonHeaders: commonHeaders, specificHeaders: specificHeaders,
                  serverTrustManager: certificate.serverTrustManager, cachePolicy: cachePolicy)
    }

    public convenience init(type: EnvironmentSpecifying, fixturesType: FixtureTypeSpecifying,
                            commonHeaders: Headers = [:], specificHeaders: SpecificHeaders = SpecificHeaders(),
                            serverTrustManager: ServerTrustManager = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: [:]),
                            cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData) {
        self.init(type: type, baseURL: type.baseURL, name: type.name, fixturesType: fixturesType,
                  commonHeaders: commonHeaders, specificHeaders: specificHeaders,
                  serverTrustManager: serverTrustManager, cachePolicy: cachePolicy)
    }

    public convenience init(type: EnvironmentSpecifying, fixturesType: FixtureTypeSpecifying, commonHeaders: Headers = [:],
                            specificHeaders: SpecificHeaders = SpecificHeaders(), certificate: Certificate,
                            cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData) {
        self.init(type: type, baseURL: type.baseURL, name: type.name, fixturesType: fixturesType,
                  commonHeaders: commonHeaders, specificHeaders: specificHeaders,
                  serverTrustManager: certificate.serverTrustManager, cachePolicy: cachePolicy)
    }

    public func merging(headers: Headers) {
        commonHeaders?.merge(headers ?? [:], uniquingKeysWith: { $1 })
    }

    public func merging(specificHeaders: SpecificHeaders) {
        self.specificHeaders.merge(specificHeaders, uniquingKeysWith: { $1 })
    }
}
