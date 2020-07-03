//
//  GlobalData.swift
//  CovidStats
//
//  Created by Yury Kurylovich on 01.06.2020.
//  Copyright © 2020 Yury Kurylovich. All rights reserved.
//

import Foundation

struct GlobalData: Codable {
    var newConfirmed: Int
    var totalConfirmed: Int
    var newDeaths: Int
    var totalDeaths: Int
    var newRecovered: Int
    var totalRecovered: Int
    
    enum CodingKeys: String, CodingKey {
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
}
