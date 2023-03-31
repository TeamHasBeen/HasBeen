import UIKit
import ParseSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ParseSwift.initialize(applicationId: "bTrjfEICGRLTVyZfXaUkUNnunMI1hUkfnltobfLD",
                                 clientKey: "1UXSRabB76C5pqk8XhyCR11PFG5nKGlBS9YBlq4Q",
                                 serverURL: URL(string: "https://parseapi.back4app.com")!)
        
        // Create an array to store the new Destination objects that need to be saved
        var newDestionationsArray: [Destination] = []
        
        // Create a DispatchGroup to synchronize the asynchronous tasks
        let group = DispatchGroup()
        
        // Loop through the destionationsArray and check if each object is already in the database
        
        for destination in Destination.destinationsArray {
            // Enter the DispatchGroup
            
            group.enter()
            
            // Create a query to check if the destionation is already in the database
            let query = Destination.query("city" == destination.city)
            query.find { results in
                switch results {
                case .success(let destinations):
                    if destinations.isEmpty {
                        // The query did not return any results
                        newDestionationsArray.append(destination)
                    }
                case .failure(let error):
                    print("Error checking if destination is in database: \(error.localizedDescription)")

                }
                
                // Leave the DispatchGroup
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            // Save the new Destination objects that were not found in the database
            if !newDestionationsArray.isEmpty {
                newDestionationsArray.saveAll() { result in
                    switch result {
                    case .success( _ ):
                        print("Successfuly saved destinations")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

