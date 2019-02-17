//
//  Extension.swift
//  ImagePicker
//
//  Created by Joe Black on 13/02/2019.
//  Copyright © 2019 iOS Ninja. All rights reserved.
//

import Foundation

extension Decodable {
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}

extension Encodable {
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}
