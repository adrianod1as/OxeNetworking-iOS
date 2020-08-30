//
//  ErrorFilter.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 16/07/20.
//

import Foundation
import Moya

public protocol MoyaDispatcherResult {

    var result: MoyaResult { get  }
}

extension MoyaResult: MoyaDispatcherResult {

    public var result: MoyaResult {
        return self
    }
}

public protocol MoyaDispatcherResponse {

    var moyaResponse: Moya.Response { get }
}

extension Moya.Response: MoyaDispatcherResponse {

    public var moyaResponse: Moya.Response {
        return self
    }
}

public protocol ErrorFilter {

    func getDefaultError() -> Error

    func filter(error: Error) -> Error

    func filterForErrors(in result: MoyaDispatcherResult) -> MoyaResult

    func filterForErrors(in response: MoyaDispatcherResponse) throws -> Moya.Response
}
