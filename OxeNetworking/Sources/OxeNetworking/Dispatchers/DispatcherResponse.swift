//
//  Moya.Response.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 02/08/20.
//

import Foundation
import Moya
import SwiftyJSON

public protocol DispatchingResponse {

    func asDecodable<T: Decodable>(_ type: T.Type, from endpoint: TargetType, completion: @escaping GenericCompletion<T>)
    func asJSON(from endpoint: TargetType, completion: @escaping GenericCompletion<Any>)
    func asSwiftyJSON(from endpoint: TargetType, completion: @escaping GenericCompletion<JSON>)

}
