//
//  HeadersReturning.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import Moya

public protocol SampleHeadersReturning: TargetType {

    var sampleHeaders: Headers { get }
}

extension SampleHeadersReturning {

    public var sampleHeaders: Headers {
        return nil
    }
}
