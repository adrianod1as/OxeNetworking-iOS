//
//  Encodable+Ext.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import SwiftyJSON
import Alamofire

extension Encodable {

    var data: Data? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return data
    }

    var json: JSON {
        guard let jsonFromData = JSON.nonNullableJson(data: data) else {
            return .null
        }
        return jsonFromData
    }

    var rawObject: [String: Any]? {
        return json.dictionaryObject
    }

    public var parameters: Parameters {
        return rawObject ?? [:]
    }

    public var asHeaders: Headers {
        guard let headers = rawObject as? Headers else {
            return [:]
        }
        return headers
    }

}

extension Data {

    func decode<T: Decodable>(_ decodableType: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(decodableType, from: self)
            return result
        } catch let error as NSError {
            debugPrint(error.description)
            return nil
        }
    }
}
