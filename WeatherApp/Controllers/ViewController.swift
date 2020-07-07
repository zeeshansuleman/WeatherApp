import UIKit
import MapKit
import ANLoader
class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(tap)
    }
    @objc func doubleTapped(sender: UIGestureRecognizer){
        let locationInView = sender.location(in: self.mapView)
        let locationOnMap = self.mapView.convert(locationInView, toCoordinateFrom: self.mapView)
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.coordinate = locationOnMap
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func addAnnotation(location: CLLocationCoordinate2D,temp:Float){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Temperature"
        annotation.subtitle = "\(temp)"
        self.mapView.addAnnotation(annotation)
    }
}

