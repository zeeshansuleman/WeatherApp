import UIKit
import Alamofire
import SwiftyJSON

class ApiManager: NSObject {
static let shared = ApiManager()
    
    func getWeather(latitude:Double,longitude:Double,_ completion:@escaping (JSON?,String?)->Void){
        let path =  Constant.baseUrl + "?lat=\(latitude)&lon=\(longitude)&appid=\(Constant.apiKey)"
        let request =
            AF.request(path, method: .get, parameters: nil,headers:nil)
            request.responseString { response in
            if let data = response.data {
                let json = JSON(data)
                    print(json)
                    completion(json,nil)
            }else {
                completion(nil,"Error in request")
            }
        }
        
    }
}
