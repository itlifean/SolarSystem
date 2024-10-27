//
//  PlanetDetailsViewController.swift
//  Planets
//
//  Created by Ana Oganesiani on 27.10.24.
//


import UIKit

class PlanetDetailsViewController: UIViewController {
    
    var planet: Planet
    let favoriteButton = UIButton()
    
    init(planet: Planet) {
        self.planet = planet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {

        if navigationItem.titleView == nil {
            let titleLabel = UILabel()
            titleLabel.text = self.planet.name
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.textColor = UIColor.white
            titleLabel.textAlignment = NSTextAlignment.center

            let containerView = UIView()
            containerView.addSubview(titleLabel)


            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])

            self.navigationItem.titleView = containerView
        }


        if let rightBarButtonItem = self.navigationItem.rightBarButtonItem {
            rightBarButtonItem.customView?.frame = CGRect(x: UIScreen.main.bounds.width - 44, y: 0, width: 44, height: 44)
        }
                super.viewDidLoad()

        if navigationItem.titleView == nil {
            let titleLabel = UILabel()
            titleLabel.text = self.planet.name
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.textColor = UIColor.white
            titleLabel.textAlignment = NSTextAlignment.center

            let containerView = UIView()
            containerView.addSubview(titleLabel)

            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])

            self.navigationItem.titleView = containerView
        }

        if let rightBarButtonItem = self.navigationItem.rightBarButtonItem {
            rightBarButtonItem.customView?.frame = CGRect(x: UIScreen.main.bounds.width - 44, y: 0, width: 44, height: 44)
        }
                view.backgroundColor = UIColor(red: 33/255, green: 13/255, blue: 4/255, alpha: 1.0)
        setupNavigationBar()
        setupPlanetImage()
        setupDetailsView()
    }
    
    private func setupNavigationBar() {

        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .orange
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        let titleLabel = UILabel()
        titleLabel.text = planet.name
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        favoriteButton.tintColor = planet.isFavorited ? .yellow : .white
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        

        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, favoriteButton])
        titleStackView.axis = .horizontal
        titleStackView.spacing = 80
        titleStackView.alignment = .center
        navigationItem.titleView = titleStackView
    }

    private func setupPlanetImage() {
    
        let planetImageView = UIImageView()
        planetImageView.image = UIImage(named: planet.imageName)
        planetImageView.contentMode = .scaleAspectFit
        planetImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(planetImageView)

  
        NSLayoutConstraint.activate([
            planetImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            planetImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            planetImageView.widthAnchor.constraint(equalToConstant: 300),
            planetImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func setupDetailsView() {
   
        let areaLabel = createStyledLabel(title: "Area", value: planet.area)
        let temperatureLabel = createStyledLabel(title: "Temperature", value: planet.temperature)
        let massLabel = createStyledLabel(title: "Mass", value: planet.mass)
        
        let stackView = UIStackView(arrangedSubviews: [areaLabel, temperatureLabel, massLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
   
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func createStyledLabel(title: String, value: String) -> UIView {
     
        let containerView = UIView()
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 2.0
        containerView.layer.cornerRadius = 10.0
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = .white
        valueLabel.font = UIFont.systemFont(ofSize: 20)
        valueLabel.textAlignment = .right
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(valueLabel)
        

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            valueLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])

        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        return containerView
    }


    @objc private func toggleFavorite() {
        planet.isFavorited.toggle()
        favoriteButton.tintColor = planet.isFavorited ? .yellow : .white
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

