//
//  AddCityViewController.swift
//  MyWeather
//
//  Created by HAKAN on 24.11.2024.
//

import UIKit

/// Protocol gives us to add more citcy to track weather forecast with just a function
protocol AddCityViewControllerDelegate: AnyObject {
    func addCity(_ city: /*City*/ String)
    func didSelect(_ city: String)
    
}

class AddCityViewController: UIViewController {
   
    

    weak var delegate: AddCityViewControllerDelegate?
    
// MARK: - components
    private let tview: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        return view
    }()
    
    private let searchController: UISearchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.searchBar.placeholder = "Search cities..."
            controller.obscuresBackgroundDuringPresentation = false
            return controller
        }()
        
    
    private var cities = ["Ankara", "Istanbul", "Bursa", "Samsun", "Konya"]
   
    private var filteredItems: [String] = []
    
  
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), style: .done, target: self, action: #selector(didTApToadd))
        
        setTableView()
        setupSearchBar()
        UserDefaults.standard.set(cities, forKey: "cities")
        var citites = UserDefaults.standard.stringArray(forKey: "cities")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tview.frame = view.frame
    }
    
    //MARK: - Fucntions
    
    private func setTableView() {
        view.addSubview(tview)
        
        tview.delegate = self
        tview.dataSource = self
        tview.separatorColor = .clear
        
    }
    
    
   
    @objc private func didTApToadd() {
        
        let ac = UIAlertController(title: "City name", message: "Please type a city name", preferredStyle: .alert)
        
        ac.addTextField { textField in
            textField.placeholder = "Enter city name..."
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
            if let cityTextField = ac.textFields?.first,
               let cityName = cityTextField.text {
                self?.cities.append(cityName)
                print(cityName)
                self?.orderingCities()
                self?.tview.reloadData()
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
      
        
    }
    
    
    /// orderingCities function allow us to order city array
    private func orderingCities() {
        var tempCities: [String] = []
       
        for city in cities {
            if !tempCities.contains(city) {
                tempCities.insert(city, at: 0)
            }
        }
        
        
        cities = tempCities
    }
    
    private func setupSearchBar() {
            // Setup SearchController
            searchController.searchResultsUpdater = self
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            definesPresentationContext = true
        }
        
    // Helper method to filter items
    private func filterContentForSearchText(_ searchText: String) {
        filteredItems = cities.filter { item in
                return item.lowercased().contains(searchText.lowercased())
            }
            tview.reloadData()
        }
    
    private var isSearchBarEmpty: Bool {
            return searchController.searchBar.text?.isEmpty ?? true
        }
        
    private var isFiltering: Bool {
            return searchController.isActive && !isSearchBarEmpty
        }

}


//MARK: - TableView Extension
extension AddCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredItems.count : cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = isFiltering ? filteredItems[indexPath.row] : cities[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(cities[indexPath.row])
        navigationController?.popToRootViewController(animated: true)
        cities.insert(self.cities[indexPath.row], at: 0)
        self.delegate?.didSelect(cities[indexPath.row])
    }
   
    
    
}
// MARK: - SearchBar Extension
extension AddCityViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
   
}

//
//#Preview {
//    AddCityViewController()
//}
