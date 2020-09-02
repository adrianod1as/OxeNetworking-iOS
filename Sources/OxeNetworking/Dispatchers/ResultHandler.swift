//
//  ResultHandler.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import Moya

public protocol ResultHandler {

    func handleRequest(response: Response?, error: Error?, completion: @escaping GenericCompletion<Void>)
    func handleRequest(response: Response?, completion: @escaping GenericCompletion<Void>)
    func handleRequest(error: Error?, completion: @escaping GenericCompletion<Void>)
}

public extension ResultHandler {

    func handleRequest(response: Response?, error: Error?, completion: @escaping GenericCompletion<Void>) {
        handleRequest(response: response) { _ in
            self.handleRequest(error: error) { _ in
                completion(.success(()))
            }
        }
    }
}
