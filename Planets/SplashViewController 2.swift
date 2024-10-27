
import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown
        setupSplashLabel()
        
 
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.navigateToPlanetsScreen()
        }
    }
    
    private func setupSplashLabel() {
        let label = UILabel()
        label.text = "Solar System"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
      
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func navigateToPlanetsScreen() {
        let planetsVC = PlanetsViewController()
        let navigationController = UINavigationController(rootViewController: planetsVC)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
}
