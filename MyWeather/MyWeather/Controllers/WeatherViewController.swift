


import UIKit

class WeatherViewController: UIViewController {
    
    
    // MARK: - Componenets
    lazy var weatherView = WeatherView(frame: view.frame)
   
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getCityData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
      
    }
    
    //MARK: - Functions
    @objc private func didTapAdd() {
        let addCityVC = AddCityViewController()
        addCityVC.delegate = self
        navigationController?.pushViewController(addCityVC, animated: true)
    }
    
    @objc private func didTApToSettings() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        let config = UIImage.SymbolConfiguration(pointSize: 20)
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus", withConfiguration: config), style: .done, target: self, action: #selector(didTapAdd))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill", withConfiguration: config), style: .done, target: self, action: #selector(didTApToSettings))
        
        view.addSubview(weatherView)
        
        weatherView.delegate = self
        
    }
    
    
    public func didSelectCity(_ city: String) {
      
        //do something
    }
    
    
    private func getCityData() {
        
        APIService.shared.fetchWeatherData(city: weatherView.cityNameLabel.text!) { result in
              
            switch result {
                case .success(let weatherResponse):
                let viewModel = WeatherResponseViewModel(from: weatherResponse)
                DispatchQueue.main.async {
                    self.weatherView.updateUI(with: viewModel)
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    

   
    
   
}


extension WeatherViewController: AddCityViewControllerDelegate {
    func didSelect(_ city: String) {
        weatherView.cityNameLabel.text = city
        //do something
        getCityData()
    }
    
    func addCity(_ city: String) {
//        weatherView.addSubview(city)
    }
}


extension WeatherViewController: WeatherViewDelegate {
    func didTapToProperties() {
        
    }
}
