//
//  Country.swift
//  HM21-S.M
//
//  Created by Mcbook Pro on 11.08.22.
//

import Foundation

//struct CountryesResponseData : Codable {
//    var countries: [Country]
//}

struct Country: Decodable {
    let capital: String?
    let name: String
    let flags: Flags
}

struct Flags: Decodable {
    let png: String
}

