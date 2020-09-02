//
//  QueryArrayEncoding.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import Moya
import Alamofire

public struct QueryArrayEncoding: ParameterEncoding {

    public static var `default`: QueryArrayEncoding { return QueryArrayEncoding() }

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        guard let parameters = parameters else {
            return request
        }
        guard let url = request.url else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
            urlComponents.percentEncodedQuery = percentEncodedQuery
            request.url = urlComponents.url
        }
        return request
    }

    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }

    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: key, value: value)
            }
        } else if let value = value as? NSNumber {
            components.append((key, value.isBool ? value.boolValueDescription : value.description))
        } else {
            components.append((key, "\(value)"))
        }
        return components
    }
}
