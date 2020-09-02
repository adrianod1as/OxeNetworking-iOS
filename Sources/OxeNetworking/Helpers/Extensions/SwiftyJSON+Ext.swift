//
//  SwiftyJSON+Ext.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import SwiftyJSON

extension JSON {

    static func nonNullable(_ any: Any) -> JSON? {
        guard let data = any as? Data else {
            return nonNullableJson(any)
        }
        return nonNullableJson(data: data)
    }

    internal static func nonNullableJson(_ object: Any) -> JSON? {
        let json = JSON(object)
        guard json != JSON.null else {
            return nil
        }
        return json
    }

    internal static func nonNullableJson(stringData: Data?) -> JSON? {
        guard let data = stringData else {
            return nonNullableJson(stringData as Any)
        }
        let json = JSON(String(data: data, encoding: .utf8) as Any)
        guard json != JSON.null else {
            return nonNullableJson(data as Any)
        }
        return json
    }

    static func nonNullableJson(data: Data?) -> JSON? {
        guard let info = data, let json = try? JSON(data: info) else {
            return nonNullableJson(stringData: data)
        }
        return json
    }

    func decode<T: Decodable>(_ decodableType: T.Type) -> T? {
        guard let data = self.dataObject else { return nil }
        return data.decode(decodableType)
    }

    var dataObject: Data? {
        if let data = try? self.rawData() {
            return data
        } else if let data = try? self.rawData(options: .prettyPrinted) {
            return data
        } else if let string = self.rawString(), let data = string.data(using: .utf8) {
            return data
        }
        return nil
    }

}
