import UIKit
import ParseSwift

class StreamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var noDestinationsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var favoriteDestinations = [Destination]()
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set up activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        queryFavorites(for: User.current!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteDestinations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StreamCell", for: indexPath) as? StreamCell else {
            return UITableViewCell()
        }
        cell.configure(with: favoriteDestinations[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFavorite" {
            if let destinationTC = segue.destination as? DetailTabBarController,
               let indexPath = tableView.indexPathForSelectedRow {
                destinationTC.destination = favoriteDestinations[indexPath.row]
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
    
    private func queryFavorites(for user: User) {
        showActivityIndicator()
        self.favoriteDestinations.removeAll() // Clear the array before fetching new destinations
        do {
            let query = try UserDestination.query("user" == Pointer(user))

            query.find { [weak self] result in
                switch result {
                case .success(let favorites):
                    let destinations = favorites.map { $0.destination?.toObject() } // Get the destination pointers
                    for destination in destinations { // Loop through the destination pointers
                        let destinationQuery = Destination.query("objectId" == destination?.objectId) // Get the destination
                        destinationQuery.find { destinationResult in
                            switch destinationResult {
                            case .success(let destination):
                                self?.favoriteDestinations.append(contentsOf: destination)
                                // Update the table view on the main thread
                                DispatchQueue.main.async {
                                    self?.tableView.reloadData()
                                    self?.hideActivityIndicator()
                                    self?.noDestinationsLabel.isHidden = !self!.favoriteDestinations.isEmpty
                                }

                            case .failure(let error):
                                print("Error fetching destinations: \(error.localizedDescription)")
                            }
                        }
                    }
                    if favorites.isEmpty {
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                            self?.hideActivityIndicator()
                            self?.noDestinationsLabel.isHidden = false
                        }
                    }
                case .failure(let error):
                    print("Error fetching favorites: \(error.localizedDescription)")
                }
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
}
