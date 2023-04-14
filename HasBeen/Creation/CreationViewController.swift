import UIKit
import ParseSwift

class CreationViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView!
    var randomDestination: Destination?
    private var isInitialLoad = true
    @IBOutlet weak var randomizeButton: UIButton!
    
    @IBAction func onLogoutTapped(_ sender: Any) {
        showConfirmLogoutAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showActivityIndicator()
        randomizeButton.isEnabled = false
        fetchRandomDestination()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let destinationTC = segue.destination as? DetailTabBarController {
                destinationTC.destination = self.randomDestination
            }
        }
    }
    
    private func fetchRandomDestination() {
        let query = Destination.query()
        
        query.find { result in
            DispatchQueue.main.async {
                self.hideActivityIndicator()
                self.randomizeButton.isEnabled = true
            }
            
            switch result {
            case .success(let objects):
                let randomDestination = objects.randomElement()
                self.randomDestination = randomDestination
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func showActivityIndicator() {
            activityIndicator.startAnimating()
            // Optional: Disable user interaction while loading
            view.isUserInteractionEnabled = false
        }

    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        // Optional: Re-enable user interaction after loading
        view.isUserInteractionEnabled = true
    }
    
    private func showConfirmLogoutAlert() {
        let alertController = UIAlertController(title: "Log out of \(User.current?.username ?? "current account")?", message: nil, preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

}

