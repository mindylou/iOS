//
//  EventDetailViewController.swift
//  EventfulAPI
//
//  Created by Mindy Lou on 1/27/17.
//  Copyright © 2017 Mindy Lou. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    var eventID: String!
    var event: Event!
    
    var photosImageView: UIImageView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var addressLabel: UILabel!
    var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Event"
        view.backgroundColor = .white
        
        layoutSubviews()
        
    }
    
    func layoutSubviews() {
        photosImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.4))
        photosImageView.clipsToBounds = true
        photosImageView.image = event.image
        photosImageView.contentMode = .scaleAspectFill
        if let navFrame = navigationController?.navigationBar.frame {
            photosImageView.frame = CGRect(x: 0, y: navFrame.maxY, width: view.frame.width, height: view.frame.height * 0.3)
        }
        view.addSubview(photosImageView)
        
        titleLabel = UILabel(frame: CGRect(x: 12, y: photosImageView.frame.maxY + 12, width: view.frame.maxX - 12, height: view.frame.height * 0.1))
        titleLabel.textColor = .dtwFadedRed
        titleLabel.text = event.eventTitle
        titleLabel.numberOfLines = 5
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = UIFont.dtw16DarkGrayRegularFont()?.withSize(24)
        view.addSubview(titleLabel)
        
        timeLabel = UILabel(frame: CGRect(x: 12, y: titleLabel.frame.maxY, width: view.frame.width - 10, height: view.frame.height * 0.05))
        timeLabel.textColor = UIColor.dtwSlateGrey
        timeLabel.text = changeDateFormat(dateInEventfulFormat: event.eventStartTime)
        timeLabel.font = UIFont.dtw14LightGrayRegularFont()
        view.addSubview(timeLabel)
        
        addressLabel = UILabel(frame: CGRect(x: 12, y: timeLabel.frame.maxY, width: view.frame.width, height: view.frame.height * 0.05))
        addressLabel.textColor = .dtwSlateGrey
        addressLabel.font = UIFont.dtw14DarkGrayRegularFont()
        addressLabel.text = event.venueName + ", " + event.eventAddress
        view.addSubview(addressLabel)
        
        descriptionLabel = UILabel(frame: CGRect(x: 10, y: addressLabel.frame.maxY, width: view.frame.maxX - 10, height: view.frame.height * 0.15))
        descriptionLabel.font = UIFont.dtw14DarkGrayRegularFont()
        descriptionLabel.textColor = UIColor.dtwSlateGrey
        descriptionLabel.text = event.eventDescription
        descriptionLabel.numberOfLines = 10
        descriptionLabel.lineBreakMode = .byWordWrapping
        view.addSubview(descriptionLabel)

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


}
