//
//  ViewController.swift
//  CovidStats
//
//  Created by Yury Kurylovich on 31.05.2020.
//  Copyright © 2020 Yury Kurylovich. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UITableViewController {
    
    let covidURL = "https://api.covid19api.com/summary"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

}

extension MainViewController {
    func fetchData() {
        let request = AF.request(covidURL)
        request.responseJSON { (data) in
            print(data)
        }
    }
}

