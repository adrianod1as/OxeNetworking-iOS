//
//  Typealiases.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import Moya
import Result

public typealias Headers = [String: String]?

public typealias SpecificHeaders = [String: Headers]

public typealias GenericCompletion<T> = (_ result: Swift.Result<T, AnyError>) -> Void

public typealias MoyaResult =  Swift.Result<Response, MoyaError>
