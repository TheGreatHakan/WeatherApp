
import UIKit
import SDWebImage

protocol WeatherViewDelegate: AnyObject {
    func didTapToProperties()
   
}

class WeatherView: UIView {
    
    
    weak var delegate: WeatherViewDelegate?
    
    // Mark: -Properties
    
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "San Francisco"
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .label
        return label
    }()
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "19°C"
        label.font = .systemFont(ofSize: 100, weight: .heavy)
        label.textColor = .label
        return label
    }()
    lazy var weatherNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Partly Cloudy"
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.textColor = .label
        return label
    }()
    
    lazy var weatherImgView: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 100, weight: UIImage.SymbolWeight.heavy,scale: .large)
        
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFill
        imageview.image = UIImage(systemName: "cloud.fill", withConfiguration: config)
        imageview.image?.withRenderingMode(.alwaysTemplate)
        return imageview
    }()
    
  
    let stackview: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .equalSpacing
        view.alignment = .center    
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let detailsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.2)
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    

    private lazy var windSpeedView = WeatherPartialView()
    private lazy var humidityView = WeatherPartialView()
    private lazy var pressureView = WeatherPartialView()
   


    
    // MARK: -lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        windSpeedView.setTitle(with: "Wind")
        humidityView.setTitle(with: "Humidity")
        pressureView.setTitle(with: "Pressure")
        
        windSpeedView.setIconImage(with:  "wind")
        humidityView.setIconImage(with:  "humidity")
        pressureView.setIconImage(with:  "tirepressure")
        
        stackview.addArrangedSubview(windSpeedView)
        stackview.addArrangedSubview(humidityView)
        stackview.addArrangedSubview(pressureView)
        
        addSubview(cityNameLabel)
        addSubview(weatherImgView)
        addSubview(valueLabel)
        addSubview(weatherNameLabel)
        addSubview(stackview)
        addSubview(detailsContainerView)
        
        
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 45),
            cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            weatherImgView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherImgView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor,constant: 20),
            
            valueLabel.topAnchor.constraint(equalTo: weatherImgView.bottomAnchor, constant: 20),
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            weatherNameLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 20),
            weatherNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            detailsContainerView.topAnchor.constraint(equalTo: weatherNameLabel.bottomAnchor, constant: 30),
            detailsContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            detailsContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            detailsContainerView.heightAnchor.constraint(equalToConstant: 100),
            
            stackview.centerXAnchor.constraint(equalTo: detailsContainerView.centerXAnchor),
            stackview.centerYAnchor.constraint(equalTo: detailsContainerView.centerYAnchor),
            stackview.widthAnchor.constraint(equalTo: detailsContainerView.widthAnchor, multiplier: 0.75)
            
        ])
    }
    
    
    
   
    
    func updateUI(with model: WeatherResponseViewModel){
        
        let iconString = /*String(model.icon.dropFirst(2))*/ "https:" + model.icon
        
        cityNameLabel.text = model.cityName
        valueLabel.text = "\(model.temperature)°C"
        weatherNameLabel.text = model.condition
        weatherImgView.sd_setImage(with: URL(string: iconString))
    
        windSpeedView.updateValue(with: "\(model.windSpeed) km/h" )
        humidityView.updateValue(with: String(model.humidity ) + "%")
        pressureView.updateValue(with: String(model.pressure))
    }
    
    

    //     MARK: - Helper Methods
    /// createDetailView function gives us a chance to create a detailed view
    /// - Parameters:
    ///   - icon: icon image of property as string
    ///   - title: title of property as string
    ///   - value: valu of property as string
    /// - Returns: returns detailed view
    private func createDetailView(icon: String, title: String, value: String) -> UIView {
        
        
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = .white
        valueLabel.font = .systemFont(ofSize: 16, weight: .bold)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(valueLabel)
        
        
        NSLayoutConstraint.activate([
            
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            valueLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
}
