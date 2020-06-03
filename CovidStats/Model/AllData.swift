//
//  AllData.swift
//  CovidStats
//
//  Created by Yury Kurylovich on 01.06.2020.
//  Copyright © 2020 Yury Kurylovich. All rights reserved.
//

import Foundation

struct AllData: Codable {
    var global: GlobalData
    var allCountries: [Countries]
    var date: String

    
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case allCountries = "Countries"
        case date = "Date"
    }
}
