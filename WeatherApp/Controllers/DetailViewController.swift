import UIKit
import MapKit
import ANLoader
class DetailViewController: UIViewController {
    
    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var windspeedLable: UILabel!
    @IBOutlet weak var locationLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var placeLable: UILabel!
    var coordinate : CLLocationCoordinate2D!
    var json = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherResult()
    }
    func showData(){
        
        let weatherData = json["weather"] as? [[String:Any]]
        descriptionLable.text = weatherData?.first?["description"] as? String
        let main = json["main"] as? [String:Any]
        if let temp = main?["temp"] as? NSNumber{
            tempLable.text = "\(temp.floatValue)"
        }
        let wind = json["wind"] as? [String:Any]
        if let speed = wind?["speed"] as? NSNumber{
            windspeedLable.text = "\(speed.floatValue)"
        }
        placeLable.text = json["name"] as? String
        let coord = json["coord"] as? [String:Any]
        guard let lat = coord?["lat"] as? NSNumber,let lon = coord?["lon"] as? NSNumber else{
            return
        }
        locationLable.text = "latitude:\(lat.floatValue)\n longitude:\(lon.floatValue)"
    }
    func fetchWeatherResult(){
        ANLoader.showLoading("fetching", disableUI: true)
        ApiManager.shared.getWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { (model, error) in
            ANLoader.hide()
            self.json = model?.rawValue as! [String : Any]
            self.showData()
        }
    }
}
