import UIKit
import Nuke

class DetailViewController: UIViewController, UITableViewDataSource {
    
    var destination: Destination?
    var destinationImage: URL?
    var destinationDescription: String?
    var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        // Set up activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchDetails()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        cell.configure(image: destinationImage, description: destinationDescription)
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
    
    private func fetchDetails() {
        showActivityIndicator()
        guard let destinationName = destination?.city else { return }
        print(destinationName)
        
        let apiKey = "AIzaSyC6QInWPBBGD2-LkLuigKumaWN0QLX5vR8"
        let query = destinationName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://kgsearch.googleapis.com/v1/entities:search?query=\(query)&types=City&limit=1&indent=true&key=\(apiKey)&limit=1&indent=True"
        
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
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject],
                   let itemListElement = json["itemListElement"] as? [[String: AnyObject]],
                   let firstItem = itemListElement.first,
                   let result = firstItem["result"] as? [String: AnyObject],
                   let description = result["detailedDescription"] as? [String: AnyObject],
                   let image = result["image"] as? [String: AnyObject],
                   let imageURLString = image["contentUrl"] as? String,
                   let imageURL = URL(string: imageURLString),
                   let article = description["articleBody"] as? String {

                    DispatchQueue.main.async {
                        self?.destinationDescription = article
                        self?.destinationImage = imageURL
                        self?.tableView.reloadData()
                        self?.hideActivityIndicator()
                    }

                } else {
                    print("Error: Couldn't fetch description")
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
}

