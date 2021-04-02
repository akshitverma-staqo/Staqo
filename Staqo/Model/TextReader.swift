//
//  TextReader.swift
//  Staqo
//
//  Created by SHAILY on 16/03/21.
//

import Foundation
struct TextReader : Codable {
    var documents : [Documents]?

    enum CodingKeys: String, CodingKey {

        case documents = "documents"
    }
    init() {
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        documents = try values.decodeIfPresent([Documents].self, forKey: .documents)
    }

}
