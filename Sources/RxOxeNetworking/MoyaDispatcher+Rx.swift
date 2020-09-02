//
//  MoyaDispatcher+Rx.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 04/08/20.
//

import Foundation
import Moya
import RxSwift
import SwiftyJSON
#if !COCOAPODS
import OxeNetworking
#endif

public extension Reactive where Base: MoyaDispatcher {

    func handle(originalResult: MoyaResult) -> Single<Moya.Response> {
        Single.create { [weak base] single in
            base?.handle(originalResult: originalResult) { result in
                switch result {
                case let .success(response):
                    single(.success(response))
                case let .failure(error):
                    single(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
