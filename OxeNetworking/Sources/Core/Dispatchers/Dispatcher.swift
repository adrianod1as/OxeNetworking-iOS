//
//  Dispatcher.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import Moya
import SwiftyJSON

public protocol Dispatcher: AnyObject {

    var environment: Environment { get }
    func call(endpoint: TargetType, completion: @escaping Completion)
    func performRequest(from endpoint: TargetType, completion: @escaping GenericCompletion<Void>)
    func getResponse(from endpoint: TargetType, completion: @escaping GenericCompletion<Moya.Response>)
    func getDecodable<T: Decodable>(_ type: T.Type, from endpoint: TargetType, completion: @escaping GenericCompletion<T>)
    func getJSON(from endpoint: TargetType, completion: @escaping GenericCompletion<Any>)
    func getSwiftyJSON(from endpoint: TargetType, completion: @escaping GenericCompletion<JSON>)
}

public extension Dispatcher {

    func getDecodable<T: Decodable>(_ type: T.Type, from endpoint: TargetType, completion: @escaping GenericCompletion<T>) {
        getResponse(from: endpoint) { result in
            switch result {
            case .success(let response):
                response.asDecodable(type, from: endpoint, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getJSON(from endpoint: TargetType, completion: @escaping GenericCompletion<Any>) {
        getResponse(from: endpoint) { result in
            switch result {
            case .success(let response):
                response.asJSON(from: endpoint, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getSwiftyJSON(from endpoint: TargetType, completion: @escaping GenericCompletion<JSON>) {
        getResponse(from: endpoint) { result in
            switch result {
            case .success(let response):
                response.asSwiftyJSON(from: endpoint, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getResponse(from endpoint: TargetType, completion: @escaping GenericCompletion<Moya.Response>) {
        call(endpoint: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let moyaError):
                completion(.failure(moyaError))
            }
        }
    }

    func performRequest(from endpoint: TargetType, completion: @escaping GenericCompletion<Void>) {
        getResponse(from: endpoint) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
