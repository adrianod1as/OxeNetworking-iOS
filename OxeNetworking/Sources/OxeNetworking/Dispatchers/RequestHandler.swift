//
//  RequestHandler.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 02/08/20.
//

import Foundation
import Moya

public protocol RequestHandler: Dispatcher, ResultHandler, ErrorFilter, RequestInterceptor {}
