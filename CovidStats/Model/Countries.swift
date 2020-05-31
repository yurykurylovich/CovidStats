//
//  Countries.swift
//  CovidStats
//
//  Created by Yury Kurylovich on 31.05.2020.
//  Copyright © 2020 Yury Kurylovich. All rights reserved.
//

import Foundation

struct Countries: Codable {
    var country: String
    var newConfirmed: Int
    var totalConfirmed: Int
    var newDeaths: Int
    var totalDeaths: Int
    var newRecovered: Int
    var totalRecovered: Int
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
        case date = "Date"
    }
}
