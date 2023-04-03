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
            (viewControllers[1] as! PlaceViewController).type = "Restaurants"
            viewControllers[2].tabBarItem = UITabBarItem(title: "Sleep", image: UIImage(systemName: "bed.double.circle"), tag: 2)
            (viewControllers[2] as! PlaceViewController).type = "Hotels"
            
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
    }

    @IBAction func didTapFavorite(_ sender: Any) {
        // Code to save favorites goes here
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
            print("Third tab selected")
            self.title = "Hotels"
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
