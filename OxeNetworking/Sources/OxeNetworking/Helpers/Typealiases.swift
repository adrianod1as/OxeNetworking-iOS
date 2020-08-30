//
//  Typealiases.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import Moya

public typealias Headers = [String: String]?

public typealias SpecificHeaders = [String: Headers]

public typealias GenericCompletion<T> = (_ result: Swift.Result<T, Error>) -> Void

public typealias MoyaResult =  Swift.Result<Response, MoyaError>
