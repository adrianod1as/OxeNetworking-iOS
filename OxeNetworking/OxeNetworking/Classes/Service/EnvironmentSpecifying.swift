//
//  EnvironmentSpecying.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation

public protocol EnvironmentSpecifying {

    var name: String { get }

    var baseURL: URL? { get }

    var mayBeSimulated: Bool { get }
}
