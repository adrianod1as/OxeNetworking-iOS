//
//  ErrorFilter.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 16/07/20.
//

import Foundation
import Moya
import Alamofire

public protocol MoyaDispatcherResult {

    var result: MoyaResult { get  }
}

public struct GenericMoyaDispatcherResult: MoyaDispatcherResult {

    public let result: MoyaResult

    public init(result: MoyaResult) {
        self.result = result
    }
}

public protocol ErrorFilter {

    func getDefaultError() -> Error

    func filter(error: Error) -> Error

    func filterForErrors(in result: MoyaDispatcherResult) -> MoyaResult

    func filterForErrors(in response: Moya.Response) throws -> Moya.Response
}
