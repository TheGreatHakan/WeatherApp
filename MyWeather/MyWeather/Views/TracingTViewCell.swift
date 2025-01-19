////
////  TracingTViewCell.swift
////  MyWeather
////
////  Created by HAKAN on 17.12.2024.
////
//
//import UIKit
//
//class TracingTViewCell: UIView {
//
//    let streakImageView: UIImageView = {
//        
//        let config = UIImage.SymbolConfiguration(pointSize: 30)
//        
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(systemName: "flame", withConfiguration: config)
//        imageView.tintColor = .red
//        return imageView
//    }()
//    
//    lazy var habitLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Habit"
//        label.textColor = .label
//        label.font = .systemFont(ofSize: 35)
//        return label
//    }()
//    
//    lazy var progressView: UIProgressView = {
//        let view = UIProgressView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.progress = 30 / 50
//        view.progressTintColor = .red
//        view.progressViewStyle = .bar
//        view.backgroundColor = .blue
//        return view
//    }()
//    
//    lazy var percLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "%60"
//        label.textColor = .label
//        label.font = .systemFont(ofSize: 12, weight: .regular)
//        return label
//    }()
//    
//    lazy var streakCountLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "6"
//        label.font = .systemFont(ofSize: 35, weight: .regular)
//        label.textColor = .red
//        return label
//    }()
//    
//    let stackView: UIStackView  = {
//        let view = UIStackView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.axis = .horizontal
//        view.distribution = .equalSpacing
//        view.alignment = .center
//        view.spacing = 80
//    
//        return view
//    }()
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        
//        setUI()
//        
//    }
//    
//    
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
//
//    
//    private func setUI() {
//        addSubview(stackView)
//
//
//        addSubview(streakImageView)
//        addSubview(habitLabel)
//        addSubview(progressView)
//        addSubview(percLabel)
//        addSubview(streakCountLabel)
//        
//        NSLayoutConstraint.activate([
//
//            
//            progressView.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 20),
//            progressView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
//            progressView.widthAnchor.constraint(equalToConstant: 300),
//            progressView.heightAnchor.constraint(equalToConstant: 10),
//            
//            habitLabel.bottomAnchor.constraint(equalTo: percLabel.topAnchor,constant: -10),
//            habitLabel.leftAnchor.constraint(equalTo: percLabel.leftAnchor, constant: 0),
//            
//            streakImageView.rightAnchor.constraint(equalTo: progressView.rightAnchor, constant: 0),
//            streakImageView.bottomAnchor.constraint(equalTo: habitLabel.bottomAnchor, constant: 0),
//            
//            percLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor),
//            percLabel.leftAnchor.constraint(equalTo: progressView.leftAnchor, constant: 0),
//            
//            streakCountLabel.rightAnchor.constraint(equalTo: streakImageView.leftAnchor, constant: -5),
//            streakCountLabel.bottomAnchor.constraint(equalTo: habitLabel.bottomAnchor, constant: 0),
//        ])
//    }
//}
//
//


import SwiftUI


