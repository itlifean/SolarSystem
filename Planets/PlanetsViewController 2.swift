
import UIKit

class PlanetCell: UICollectionViewCell {
    let planetImageView = UIImageView()
    let planetNameLabel = UILabel()
    let planetAreaLabel = UILabel()
    let favoriteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        planetImageView.translatesAutoresizingMaskIntoConstraints = false
        planetImageView.contentMode = .scaleAspectFit
        planetImageView.layer.cornerRadius = 50
        planetImageView.clipsToBounds = true
        contentView.addSubview(planetImageView)
        

        planetNameLabel.translatesAutoresizingMaskIntoConstraints = false
        planetNameLabel.font = UIFont.boldSystemFont(ofSize: 26)
        planetNameLabel.textColor = .white
        planetNameLabel.textAlignment = .center
        contentView.addSubview(planetNameLabel)
        

        planetAreaLabel.translatesAutoresizingMaskIntoConstraints = false
        planetAreaLabel.font = UIFont.systemFont(ofSize: 18)
        planetAreaLabel.textColor = .lightGray
        planetAreaLabel.textAlignment = .center
        contentView.addSubview(planetAreaLabel)
        
  
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        favoriteButton.tintColor = .white
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        contentView.addSubview(favoriteButton)
    
        NSLayoutConstraint.activate([
            planetImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            planetImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            planetImageView.widthAnchor.constraint(equalToConstant: 100),
            planetImageView.heightAnchor.constraint(equalToConstant: 100),
            
            planetNameLabel.topAnchor.constraint(equalTo: planetImageView.bottomAnchor, constant: 8),
            planetNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            favoriteButton.leadingAnchor.constraint(equalTo: planetNameLabel.trailingAnchor, constant: 5),
            favoriteButton.centerYAnchor.constraint(equalTo: planetNameLabel.centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24),
            
            planetAreaLabel.topAnchor.constraint(equalTo: planetNameLabel.bottomAnchor, constant: 5),
            planetAreaLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with planet: Planet) {
        planetImageView.image = UIImage(named: planet.imageName)
        planetNameLabel.text = planet.name
        planetAreaLabel.text = planet.area
        favoriteButton.isSelected = planet.isFavorited
        favoriteButton.tintColor = planet.isFavorited ? .yellow : .white
    }
    
 
    @objc private func toggleFavorite() {
        favoriteButton.isSelected.toggle()
        favoriteButton.tintColor = favoriteButton.isSelected ? .yellow : .white
    }
}

class PlanetsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var planets: [Planet] = [
        Planet(name: "Mercury", area: "74,800,000 km²", temperature: "167°C", mass: "3.285×10²³ kg", imageName: "mercury"),
        Planet(name: "Venus", area: "460,200,000 km²", temperature: "462°C", mass: "4.867×10²⁴ kg", imageName: "venus"),
        Planet(name: "Earth", area: "510,100,100 km²", temperature: "15°C", mass: "5.972×10²⁴ kg", imageName: "earth"),
        Planet(name: "Mars", area: "144,400,000 km²", temperature: "-18°C", mass: "6.39×10²³ kg", imageName: "mars"),
        Planet(name: "Jupiter", area: "6,142×10¹⁰ km²", temperature: "-108°C", mass: "1.898×10²⁷ kg", imageName: "jupiter"),
        Planet(name: "Uranus", area: "8,083×10⁹ km²", temperature: "-224°C", mass: "8.681×10²⁵ kg", imageName: "uranus")
    ]
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let headerLabel = UILabel()
        headerLabel.text = "Planets"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 34)
        headerLabel.textColor = .white
        headerLabel.textAlignment = .center
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)
        
        view.backgroundColor = UIColor(red: 33/255, green: 13/255, blue: 4/255, alpha: 1.0)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 2 - 20, height: 200)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PlanetCell.self, forCellWithReuseIdentifier: "planetCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planets.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "planetCell", for: indexPath) as! PlanetCell
        let planet = planets[indexPath.row]
        cell.configure(with: planet)
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10) 
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlanet = planets[indexPath.row]
        let detailsVC = PlanetDetailsViewController(planet: selectedPlanet)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
