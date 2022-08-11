//
//  TableViewController.swift
//  HM21-S.M
//
//  Created by Mcbook Pro on 11.08.22.
//

import UIKit

class TableViewController: UITableViewController,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var countries = [Country]()
    
    var filteredData = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        searchBar.delegate = self
        
        
        getCountries()
        
    }
    
    private func getCountries(){
        
        APIService.shared.getCountry { countries in
            
            self.filteredData = countries
            
            self.countries = countries
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return filteredData.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        cell.textLabel?.text = filteredData[indexPath.row].name
        
        return cell
    }
    
    
    // MARK: - SearchBar Config

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            filteredData = searchText.isEmpty ? countries : countries.filter({(dataString: Country) -> Bool in
                return dataString.name.range(of: searchText, options: .caseInsensitive) != nil
            })
            
            tableView.reloadData()
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "FlagViewController") as! FlagViewController
        
        let curenCountry = filteredData[indexPath.row]
        
        _ = VC.view
        
        
        VC.nameLabel.text =  " Capital is  \(curenCountry.capital ?? "N/A") "
        
        
        if let url = URL(string: curenCountry.flags.png ) {
            
            VC.imageFlag.load(url: url)
        
        }
        
        navigationController?.pushViewController(VC, animated: true)
        
        
    }

  

}
