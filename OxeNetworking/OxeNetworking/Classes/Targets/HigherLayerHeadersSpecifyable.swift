//
//  HigherLayerHeadersSpecifyable.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation

public protocol HigherLayerHeadersSpecifyable {

    var specificHeaderTypes: [HeaderSpecifying] { get }
}

public protocol HeaderSpecifying {

    var key: String { get }

}
