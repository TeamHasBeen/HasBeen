import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    var latitude: Double?
    var longitude: Double?
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // Set mapView delegate
        mapView.delegate = self
        
        if let latitude = latitude,
           let longitude = longitude {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            addPinAtCoordinate(coordinate)
            setMapRegion(coordinate: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        }
        
    }
    
    private func addPinAtCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    private func setMapRegion(coordinate: CLLocationCoordinate2D, latitudinalMeters: CLLocationDistance, longitudinalMeters: CLLocationDistance) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
        mapView.setRegion(region, animated: true)
    }

}
