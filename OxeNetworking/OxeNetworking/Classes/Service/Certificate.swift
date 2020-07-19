//
//  Certificate.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 07/07/20.
//

import Foundation
import Alamofire

public protocol Certificate {

    var files: [CertificateFileConvertible] { get }
    var evaluatorKey: String { get }
    var allHostsMustBeEvaluated: Bool { get }
}

public extension Certificate {

    var allHostsMustBeEvaluated: Bool {
        return true
    }

    var secCertificates: [SecCertificate] {
        return files.map({ $0.secCertificate })
    }

    var trustEvaluator: PinnedCertificatesTrustEvaluator {
        return PinnedCertificatesTrustEvaluator(certificates: secCertificates)
    }

    var serverTrustManager: ServerTrustManager {
        return ServerTrustManager(allHostsMustBeEvaluated: allHostsMustBeEvaluated, evaluators: evaluators)
    }

    var evaluators: [String: ServerTrustEvaluating] {
        return [evaluatorKey: trustEvaluator]
    }
}

public extension Certificate where Self: CaseIterable {

    static var evaluators: [String: ServerTrustEvaluating] {
        return Dictionary(allCases.flatMap({ $0.evaluators }),
                          uniquingKeysWith: { (_, last) in last })
    }

    static var allHostsMustBeEvaluated: Bool {
        let set = Set(allCases.map({ $0.allHostsMustBeEvaluated }))
        guard set.count == 1, let allHostsMustBeEvaluated = set.first else {
            return false
        }
        return allHostsMustBeEvaluated
    }

    static var serverTrustManager: ServerTrustManager {
        return ServerTrustManager(allHostsMustBeEvaluated: allHostsMustBeEvaluated, evaluators: evaluators)
    }
}

public protocol CertificateFileConvertible {

    var name: String { get }
    var type: String { get }

}

public extension CertificateFileConvertible {

    var path: String {
        guard let path = Bundle.main.path(forResource: self.name, ofType: self.type) else {
            fatalError("Não foi possível encontrar o arquivo")
        }
        return path
    }

    var contents: CFData {
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path)) as CFData
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    var secCertificate: SecCertificate {
        guard let certificate = SecCertificateCreateWithData(nil, contents) else {
            fatalError("Não foi possível gerar o certificado")
        }
        return certificate
    }
}

public struct GenericCertificateFile: CertificateFileConvertible {

    public let name: String
    public let type: String

    public init(name: String, type: String = "der") {
        self.name = name
        self.type = type
    }
}
