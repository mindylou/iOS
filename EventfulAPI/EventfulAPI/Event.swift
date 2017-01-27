//
//  Event.swift
//  EventfulAPI
//
//  Created by Mindy Lou on 1/27/17.
//  Copyright © 2017 Mindy Lou. All rights reserved.
//

import Foundation
import SwiftyJSON

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}

class Event {
    
    var eventID: String!
    var eventURL: String!
    var eventTitle: String!
    var eventDescription: String!
    var eventAddress: String!
    var eventStartTime: String!
    var eventEndTime: String!
    var venueURL: String!
    var venueName: String!
    var imageURL: String!
    var geocoordinates: String!
    var image: UIImage!
    
    // homepage only
    init(json: JSON) {
        self.eventID = json["id"].stringValue
        self.eventURL = json["url"].stringValue
        self.eventTitle = json["title"].stringValue
        self.eventDescription = json["description"].stringValue.htmlToString
        self.eventAddress = json["venue_address"].stringValue
        self.eventStartTime = json["start_time"].stringValue
        self.eventEndTime = json["stop_time"].stringValue
        self.venueURL = json["venue_url"].stringValue
        self.venueName = json["venue_name"].stringValue
        self.imageURL = json["image"]["perspectivecrop290by250"]["url"].stringValue
        self.geocoordinates = "\(json["latitude"].stringValue),\(json["longitude"].stringValue)"
        self.image = EventfulManager.getImageFromURLString(urlString: self.imageURL)
        
    }
    
    init(id: String, url: String, title: String, description: String, address: String, start_time: String, venue_url: String, venue_name: String, image_perspectivecrop_url: String) {
        self.eventID = id
        self.eventURL = url
        self.eventTitle = title.htmlToString
        self.eventDescription = description.htmlToString
        self.eventAddress = address
        self.eventStartTime = start_time
        self.venueURL = venue_url
        self.venueName = venue_name
        self.imageURL = image_perspectivecrop_url
        self.image = EventfulManager.getImageFromURLString(urlString: self.imageURL)
    }
    
    // get event image info for event page
    func getEventImage(imageSize: String, json: JSON) -> UIImage? {
        let imageArray = json["images"]["image"].arrayValue
        if imageArray.count > 0 {
            let imageURL = imageArray[0][imageSize]["url"].stringValue
            return EventfulManager.getImageFromURLString(urlString: imageURL)
        }
        else {
            return nil
        }
    }
    
    func toJSON() -> NSDictionary {
        let eventDictionary: NSDictionary = [
            "id": self.eventID,
            "url": self.eventURL,
            "title": self.eventTitle,
            "description": self.eventDescription,
            "venue_address": self.eventAddress,
            "start_time": self.eventStartTime,
            "venue_url": self.venueURL,
            "venue_name": self.venueName,
            "image": ["perspectivecrop290by250":["url": self.imageURL]]
        ]
        
        return eventDictionary
    }
    
    static func equals(lhs: Event, rhs: Event) -> Bool {
        return lhs.eventID == rhs.eventID && lhs.eventURL == rhs.eventURL && lhs.eventTitle == rhs.eventTitle && lhs.eventDescription == rhs.eventDescription && lhs.eventAddress == rhs.eventAddress && lhs.eventStartTime == rhs.eventStartTime && lhs.venueURL == rhs.venueURL && lhs.venueName == rhs.venueName && lhs.imageURL == rhs.imageURL
    }
    
}
