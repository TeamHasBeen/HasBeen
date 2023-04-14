import UIKit
import ParseSwift

class DetailTabBarController: UITabBarController, UITabBarControllerDelegate {
    

    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    var destination: Destination?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        
        self.title = destination?.city
            
        // Get the existing view controllers
        if let viewControllers = self.viewControllers {
            // Replace the existing view controllers with the updated array
            viewControllers[1].tabBarItem = UITabBarItem(title: "Food", image: UIImage(systemName: "fork.knife.circle"), tag: 1)
            (viewControllers[1] as! PlaceViewController).type = "restaurants"
            viewControllers[2].tabBarItem = UITabBarItem(title: "Sleep", image: UIImage(systemName: "bed.double.circle"), tag: 2)
            (viewControllers[2] as! PlaceViewController).type = "hotels"
            viewControllers[3].tabBarItem = UITabBarItem(title: "See", image: UIImage(systemName: "building.columns.circle"), tag: 3)
            (viewControllers[3] as! PlaceViewController).type = "points+of+interest"
            
            // Pass the destination object to each view controller and set their titles
            for viewController in viewControllers {
                if let detailVC = viewController as? DetailViewController {
                    detailVC.destination = self.destination
                } else if let placeVC = viewController as? PlaceViewController {
                    placeVC.destination = self.destination
                }
                // Add more cases if you have more view controllers
            }
        }
        
        if let currentUser = User.current, let selectedDestination = destination {
                isFavoriteDestination(user: currentUser, destination: selectedDestination) { isFavorite in
                    DispatchQueue.main.async {
                        let imageName = isFavorite ? "heart.fill" : "heart"
                        self.favoriteButton.image = UIImage(systemName: imageName)
                    }
                }
            }
    }

    @IBAction func didTapFavorite(_ sender: Any) {
        // Code to save favorites goes here
        if let currentUser = User.current, let selectedDestination = destination {
            // Check if the destination is in the user's favorites
            isFavoriteDestination(user: currentUser, destination: selectedDestination) { isFavorite in
                if isFavorite {
                    // Remove the destination from favorites and update the button's image
                    self.removeFavorite(user: currentUser, destination: selectedDestination)
                    self.favoriteButton.image = UIImage(systemName: "heart")
                } else {
                    // Add the destination to favorites and update the button's image
                    self.addFavorite(user: currentUser, destination: selectedDestination)
                    self.favoriteButton.image = UIImage(systemName: "heart.fill")
                }
            }
        } else {
            // Handle the case where either user or destination is nil
            print("User or destination is nil")
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Do something when a tab is selected
        if viewController == self.viewControllers?[0] {
            print("First tab selected")
            self.title = destination?.city
        }
        else if viewController == self.viewControllers?[1] {
            print("Second tab selected")
            self.title = "Restaurants"

        }
        else if viewController == self.viewControllers?[2] {
            print("Second tab selected")
            self.title = "Hotels"
        }
        else if viewController == self.viewControllers?[3] {
            print("Third tab selected")
            self.title = "Sightseeing"
        }

    }
    
    private func isFavoriteDestination(user: User, destination: Destination, completion: @escaping (Bool) -> Void) {
        do {
            let query = try UserDestination.query("user" == Pointer(user))

            query.find { result in
                switch result {
                case .success(let favorites):
                    let destinations = favorites.map { $0.destination?.toObject() }
                    var isFavorite = false
                    for dest in destinations {
                        if dest?.objectId == destination.objectId {
                            isFavorite = true
                            break
                        }
                    }
                    completion(isFavorite)
                case .failure(let error):
                    print("Error fetching favorites: \(error.localizedDescription)")
                    completion(false)
                }
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    private func addFavorite(user: User, destination: Destination) {
        var favorite = UserDestination()
        do {
            favorite.user = try Pointer(user)
        } catch let error {
            print("Error: \(error)")
        }
        do {
            favorite.destination = try Pointer(destination)
        } catch let error{
            print("Error: \(error)")
        }
        favorite.save { result in
            switch result {
            case .success:
                print("Successfully added favorite")
            case .failure(let error):
                print("Error adding favorite: \(error.localizedDescription)")
            }
        }
    }
    
    private func removeFavorite(user: User, destination: Destination) {
        do {
            let query = try UserDestination.query("user" == user, "destination" == destination)
            
            query.first { result in
                switch result {
                case .success(let favorite):
                    favorite.delete { result in
                        switch result {
                        case .success:
                            print("Successfully removed favorite")
                        case .failure(let error):
                            print("Error removing favorite: \(error.localizedDescription)")
                        }
                    }
                case .failure(let error):
                    print("Error fetching favorite to delete: \(error.localizedDescription)")
                }
            }
        } catch let error {
            print("Error: \(error)")
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
