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
    
    var countriesList: [Countries] = []
    var date = String()
    let url = URL(string: "https://api.covid19api.com/summary")

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        title = dateFormat()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let item = countriesList[indexPath.row]
        
        cell.textLabel?.text = item.country
        cell.detailTextLabel?.text = String(item.totalConfirmed)
        return cell
        }
    

func dateFormat() -> String {
    let stringDate = date
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:m:ssZ"
    var date = formatter.date(from: stringDate)
    if date == nil {
        formatter.dateFormat = "yyyy-MM-dd"
        date = formatter.date(from: stringDate)
    }
    formatter.locale = Locale(identifier: "en_EN")
    formatter.dateStyle = .full
    let outputDate = formatter.string(from: date ?? Date())
    return outputDate
    }
}

extension MainViewController {
    func getData() {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let url = url else { return }
        AF.request(url)
        .validate()
            .responseDecodable(of: AllData.self) { (response) in
                guard let decodedData = response.value else { return }
                self.date = decodedData.date
                self.countriesList = decodedData.allCountries
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
        }
    }
}


