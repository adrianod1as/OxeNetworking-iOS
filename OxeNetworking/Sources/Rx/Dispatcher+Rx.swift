//
//  ReplaceMe.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 02/08/20.
//

import Foundation
import Moya
import RxSwift
import SwiftyJSON

public extension Reactive where Base: Dispatcher {

    func call(endpoint: TargetType) -> Single<Moya.Response> {
        Single.create { [weak base] single in
            base?.call(endpoint: endpoint) { result in
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

    func getDecodable<T: Decodable>(_ type: T.Type, from endpoint: TargetType) -> Single<T> {
        Single.create { [weak base] single in
            base?.getDecodable(type, from: endpoint) { result in
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

    func getJSON(from endpoint: TargetType) -> Single<Any> {
        Single.create { [weak base] single in
            base?.getJSON(from: endpoint) { result in
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

    func getSwiftyJSON(from endpoint: TargetType) -> Single<JSON> {
        Single.create { [weak base] single in
            base?.getSwiftyJSON(from: endpoint) { result in
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

    func getResponse(from endpoint: TargetType) -> Single<Moya.Response>  {
        Single.create { [weak base] single in
            base?.getResponse(from: endpoint) { result in
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

    func performRequest(from endpoint: TargetType) -> Single<Void> {
        Single.create { [weak base] single in
            base?.performRequest(from: endpoint) { result in
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
