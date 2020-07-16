//
//  Response+Ext.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import SwiftyJSON
import Moya
import Alamofire

public extension Response {

    func asDecodable<T: Decodable>(_ type: T.Type, from endpoint: TargetType, completion: @escaping GenericCompletion<T>) {
        do {
            let keypath = (endpoint as? KeyPathable)?.keyPathForData
            let decodable = try self.map(type, atKeyPath: keypath)
            completion(.success(decodable))
        } catch {
            completion(.failure(MoyaError.objectMapping(error, self).toAnyError))
        }
    }

    func asJSON(from endpoint: TargetType, completion: @escaping GenericCompletion<Any>) {
        do {
            completion(.success(try self.mapJSON()))
        } catch {
            completion(.failure(MoyaError.jsonMapping(self).toAnyError))
        }
    }

    func asSwiftyJSON(from endpoint: TargetType, completion: @escaping GenericCompletion<JSON>) {
        guard let json = JSON.nonNullable(self.data) else {
            completion(.failure(MoyaError.jsonMapping(self).toAnyError))
            return
        }
        completion(.success(json))
    }

}

