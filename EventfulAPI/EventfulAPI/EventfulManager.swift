//
//  EventfulManager.swift
//  EventfulAPI
//
//  Created by Mindy Lou on 1/27/17.
//  Copyright © 2017 Mindy Lou. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EventfulManager {
    
    static func getDataFromAPI(url: URL, completion: @escaping ([Event]?) -> Void) {
        Alamofire.request(url, method: .get)
            .validate().responseJSON { response in
                switch response.result {
                case let .success(data):
                    let everythingJSON = JSON(data)
                    let eventsJSONArray = everythingJSON["events"]["event"].arrayValue
                    
                    var events: [Event] = []
                    for eventJSON in eventsJSONArray {
                        events.append(Event(json: eventJSON))
                    }
                                        
                    completion(events)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    static func getEventFromAPI(url: URL, completion: @escaping (JSON?) -> Void) {
        Alamofire.request(url, method: .get)
            .validate().responseJSON { response in
                switch response.result {
                case let .success(data):
                    let json: JSON = JSON(data)
                    completion(json)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    static func getImageFromURLString(urlString: String) -> UIImage? {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    
}
