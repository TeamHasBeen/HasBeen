import UIKit

class PlaceViewController: UIViewController, UITableViewDataSource {
    
    var destination: Destination?
    var places: [Place] = []
    var type: String?
    var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        
        self.navigationItem.title = "Hello"
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPlaces()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Pt 1 - Pass the selected track to the detail view controller

        // Get the cell that triggered the segue
        if let cell = sender as? UITableViewCell,
           // Get the index path of the cell from the table view
           let indexPath = tableView.indexPath(for: cell),
           // Get the detail view controller
           let mapViewController = segue.destination as? MapViewController {

            // Use the index path to get the associated track
            let place = places[indexPath.row]

            // Set the track on the detail view controller
            mapViewController.latitude = place.geometry.location.lat
            mapViewController.longitude = place.geometry.location.lng
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
        let place = places[indexPath.row]
        cell.configure(with: place)
        return cell
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
    
    private func fetchPlaces() {
        showActivityIndicator()
        guard let destinationName = destination?.city else { return }
        let apiKey = "AIzaSyC6QInWPBBGD2-LkLuigKumaWN0QLX5vR8"
        let query = destinationName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(type!)+in+\(query)&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Data is nil")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(PlaceResponse.self, from: data)
                
                let places = response.results
                
                DispatchQueue.main.async {
                    // Update UI with parsed data
                    self?.places = places
                    self?.tableView.reloadData()
                    self?.hideActivityIndicator()
                }

            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
            
        }
        
        task.resume()
    }
    
}

