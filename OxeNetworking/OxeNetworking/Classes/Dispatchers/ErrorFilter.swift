//
//  ErrorFilter.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 16/07/20.
//

import Foundation
import Moya
import Alamofire

public protocol ErrorFilter {

    func getDefaultError() -> Error

    func filter(error: Error) -> Error

    func filterForErrors(in result: MoyaResult) -> MoyaResult

    func filterForErrors(in response: Moya.Response) throws -> Moya.Response
}

public extension ErrorFilter {

    func filterForErrors(in result: MoyaResult) -> MoyaResult {
        let moyaError = result.failure
        let underlyingResponse = result.success ?? moyaError?.response
        do {
            if let response = underlyingResponse {
                return .success(try self.filterForErrors(in: response))
            }
            let error = (moyaError?.underlyingError ?? moyaError) ?? getDefaultError()
            return .failure(MoyaError.underlying(self.filter(error: error), underlyingResponse))
        } catch {
            return .failure(MoyaError.underlying(error, underlyingResponse))
        }
    }
}
