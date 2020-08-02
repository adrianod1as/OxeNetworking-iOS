//
//  CertificateFileConvertible.swift
//  OxeNetworking
//
//  Created by Adriano Dias on 21/07/20.
//

import Foundation
import Alamofire

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

public struct CommonCertificateFile: CertificateFileConvertible {

    public let name: String
    public let type: String

    public init(name: String, type: String = "der") {
        self.name = name
        self.type = type
    }
}
