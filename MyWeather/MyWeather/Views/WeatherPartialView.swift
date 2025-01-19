//
//  WeatherPartialView.swift
//  MyWeather
//
//  Created by HAKAN on 1.12.2024.
//

import UIKit

class WeatherPartialView: UIView {

    
 
    
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person")
        view.tintColor = .gray
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    
    lazy var  valueLabel: UILabel = {
        let label = UILabel()
        label.text = "value"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
   
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
       addSubview(iconImageView)
       addSubview(titleLabel)
       addSubview(valueLabel)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        
        NSLayoutConstraint.activate([
            
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    
    // MARK: - Helper Methods
    
    func setTitle(with title: String) {
        titleLabel.text = title
    }
    
    func setIconImage(with imageString: String) {
        iconImageView.image = UIImage(systemName: imageString)
    }
    
    func updateValue(with model: String) {
        valueLabel.text = model
    }
    
}

#Preview {
    WeatherPartialView()
}
