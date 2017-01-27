//
//  EventTableViewCell.swift
//  EventfulAPI
//
//  Created by Mindy Lou on 1/27/17.
//  Copyright © 2017 Mindy Lou. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventTableViewCell: UITableViewCell {
    var eventImageView: UIImageView!
    var eventTitleLabel: UILabel!
    var eventDescriptionLabel: UILabel!
    var eventTimeLabel: UILabel!
    var categoriesArray = [String]()
    var categoryLabelArray = [UILabel]()
    var categoriesView: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .none
        
        eventImageView = UIImageView()
        eventTitleLabel = UILabel()
        //        eventDescriptionLabel = UILabel()
        eventTimeLabel = UILabel()
        categoriesView = UIView()
        
        eventImageView.clipsToBounds = true
        
        addSubview(eventImageView)
        addSubview(eventTitleLabel)
        //        addSubview(eventDescriptionLabel)
        addSubview(eventTimeLabel)
        addSubview(categoriesView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        eventTitleLabel.frame = CGRect(x: self.frame.width * 12/375, y: 13, width: self.frame.width * 273/375, height: 22)
        eventTitleLabel.font = UIFont.dtw16DarkGrayRegularFont()
        eventTitleLabel.textColor = .dtwSlateGrey
        
        eventImageView.frame = CGRect(x: self.frame.width * 297/375, y: 13, width: 66, height: 66)
        eventImageView.contentMode = .scaleAspectFill
        
        eventTimeLabel.frame = CGRect(x: self.frame.width * 12/375, y: 35, width: self.frame.width * 273/375, height: 19)
        eventTimeLabel.font = UIFont.dtw14LightGrayRegularFont()
        eventTimeLabel.textColor = .dtwCoolGrey
        
        categoriesView = UIView(frame: CGRect(x: 0, y: 60, width: self.frame.width * 297/375, height: 16))
        categoriesView.clipsToBounds = true
        
    }
    
    func setup(eventImage: UIImage?, eventTitle: String, eventDescription: String, eventStartTime: String, eventStopTime: String, venue: String, id: String) {
        
        eventImageView.image = eventImage
        eventTitleLabel.text = eventTitle
        eventTimeLabel.text = "\(changeDateFormat(dateInEventfulFormat: eventStartTime)) @ \(venue)"
        categoriesArray = []
        
    }
    
    func loadCategories(id: String) {
        if let url = URL(string: "http://api.eventful.com/json/events/get?app_key=Xw342KppwRTgMZMF&id=\(id)") {
            
            EventfulManager.getEventFromAPI(url: url, completion: { (json) in
                if let categoriesJSONArray = json?["categories"]["category"].arrayValue {
                    self.categoriesArray = []
                    for categoryJSON in categoriesJSONArray {
                        let categoryTagString = "#\(categoryJSON["id"].stringValue)"
                        self.categoriesArray.append(categoryTagString)
                    }
                    
                    if self.categoriesArray.count > 2 {
                        self.addCategorySubviews(categoriesArray: self.categoriesArray, numberOfCategories: 1)
                    } else {
                        self.addCategorySubviews(categoriesArray: self.categoriesArray, numberOfCategories: self.categoriesArray.count-1)
                    }
                }
                
            })
        }
    }
    
    func changeDateFormat(dateInEventfulFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let dateObj = dateFormatter.date(from: dateInEventfulFormat) {
            dateFormatter.dateFormat = "EEE, MMM dd, h:mm a"
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            return dateFormatter.string(from: dateObj)
        }
        
        return "error"
    }
    
    func addCategorySubviews(categoriesArray: [String], numberOfCategories: Int) {
        var spacing: CGFloat = 12
        for index in 0...numberOfCategories {
            let categoryLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 65, height: 16))
            categoryLabel.text = categoriesArray[index]
            categoryLabel.backgroundColor = UIColor.dtwFadedRed65
            categoryLabel.textColor = .white
            categoryLabel.font = UIFont.dtw14WhiteRegularFont()
            categoryLabel.textAlignment = .center
            categoryLabel.sizeToFit()
            categoryLabel.numberOfLines = 0
            categoryLabel.frame = CGRect(x: spacing, y: 0, width: categoryLabel.frame.width + 12, height: 16)
            self.categoriesView.addSubview(categoryLabel)
            self.addSubview(categoriesView)
            self.categoryLabelArray.append(categoryLabel)
            spacing = categoryLabel.frame.maxX + 6
        }
}
}

