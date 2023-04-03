import UIKit
import ParseSwift

class CreationViewController: UIViewController {
    
    var randomDestination: Destination?
    private var isInitialLoad = true

    @IBAction func onLogoutTapped(_ sender: Any) {
        showConfirmLogoutAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRandomDestination()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isInitialLoad {
            isInitialLoad = false
        } else {
            fetchRandomDestination()
        }
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
            switch result {
            case .success(let objects):
                let randomDestination = objects.randomElement()
                self.randomDestination = randomDestination
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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

