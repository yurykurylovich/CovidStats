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
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        searchController.isActive && !isSearchBarEmpty
    }
    var countriesList: [Countries] = []
    var filteredCountries: [Countries] = []
    var date = String()
    let url = URL(string: "https://api.covid19api.com/summary")

    override func viewDidLoad() {
        super.viewDidLoad()
        // setting up searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Country"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        getData()
        title = dateFormat()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCountries.count
        }
        return countriesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let item: Countries
        if isFiltering {
            item = filteredCountries[indexPath.row]
        } else {
            item = countriesList[indexPath.row]
        }
    //    let item = countriesList[indexPath.row]
        cell.textLabel?.text = item.country
        cell.detailTextLabel?.text = String(item.totalConfirmed)
        return cell
        }
    
    func filteredCountries(_ searchText: String) {
        filteredCountries = countriesList.filter {
            (country:Countries) -> Bool in
            return country.country.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
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

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filteredCountries(searchBar.text!)
    }
}


