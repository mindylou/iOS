//
//  ViewController.swift
//  EventfulAPI
//
//  Created by Mindy Lou on 1/27/17.
//  Copyright © 2017 Mindy Lou. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol ReloadEventViewControllerDelegate {
    func reloadURL(urlString: String, sortByDate: Bool)
    func setURLToReload(urlString: String)
    func setTagsArray(tagList: [String])
    func setDateDistance(date: String, distance: String)
}

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, ReloadEventViewControllerDelegate {

    var tableView: UITableView!
    var locationManager: CLLocationManager!
    var userLocationCoordinates: String! = ""
    var eventsList: [Event]! = [Event]()
    var filterButton: UIButton!
    var reloadURLString: String!
    var URLToReload: String = ""
    var pageNumber: Int = 1
    var tagLabelArray = [String]()
    var cancelButtonList = [UIButton]()
    var tagUILabelArray = [UILabel]()
    var dateString = ""
    var distanceString = ""
    var dateLabel: UILabel!
    var dateLineLabel: UILabel!
    var distanceLabel: UILabel!
    var distanceLineLabel: UILabel!
    var activityIndicator: UIActivityIndicatorView?
    var headerView: UIView!
    var headerViewDateWarsLabel: UILabel!
    var headerViewLineLabel: UILabel!

    static var loadActivityController: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Events"
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

        layoutSubviews()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for label in tagUILabelArray {
            label.removeFromSuperview()
        }
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        setDateDistanceLabels(date: dateString, distance: distanceString)
        setTagsDisplay(buttonList: tagLabelArray)
        
    }
    
    func layoutSubviews() {
        if let navigation = self.navigationController?.navigationBar {
            headerView = UIView(frame: CGRect(x: 0, y: navigation.frame.maxY, width: self.view.frame.width, height: 47))
        } else {
            headerView = UIView(frame: CGRect(x: 0, y: view.frame.height * 112/603, width: view.frame.width, height: 47))
        }
        headerView.backgroundColor = .white
        headerView.translatesAutoresizingMaskIntoConstraints = true
        headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        headerViewDateWarsLabel = UILabel(frame: CGRect(x: 12, y: 13, width: 258.5, height: 22))
        headerViewDateWarsLabel.text = "Events near you"
        headerViewDateWarsLabel.font = UIFont.dtw16DarkGrayRegularFont()
        headerViewDateWarsLabel.textColor = .dtwSlateGrey
        headerViewLineLabel = UILabel(frame: CGRect(x: 0, y: headerView.frame.height - 0.5, width: view.frame.width, height: 0.5))
        headerViewLineLabel.backgroundColor = UIColor.dtwPaleGrey
        filterButton = UIButton(frame: CGRect(x: view.frame.width * 330/375, y: 12, width: 33, height: 22))
        filterButton.setTitle("Filter", for: .normal)
        filterButton.titleLabel?.textAlignment = .right
        filterButton.titleLabel?.font = UIFont.dtw14RedRegularFont()
        filterButton.setTitleColor(.dtwFadedRed, for: .normal)
        filterButton.addTarget(self, action: #selector(transitionToFilterViewController), for: .touchUpInside)
        headerView.addSubview(headerViewDateWarsLabel)
        headerView.addSubview(headerViewLineLabel)
        headerView.addSubview(filterButton)
        view.addSubview(headerView)
        
        tableView = UITableView(frame: CGRect(x: 0, y: headerView.frame.maxY, width: view.frame.width, height: view.frame.height * 497/603))
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .dtwPaleGrey
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 91
        tableView.backgroundColor = .dtwPaleGrey
        
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "Reuse")
        
        dateLabel = UILabel()
        headerView.addSubview(dateLabel)
        dateLineLabel = UILabel()
        headerView.addSubview(dateLineLabel)
        distanceLabel = UILabel()
        headerView.addSubview(distanceLabel)
        distanceLineLabel = UILabel()
        headerView.addSubview(distanceLineLabel)
    }
    
    func transitionToFilterViewController() {
        let filterVC = FilterViewController()
        filterVC.userLocationCoordinates = self.userLocationCoordinates
        filterVC.delegate = self
        navigationController?.pushViewController(filterVC, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = manager.location!.coordinate
        self.userLocationCoordinates = "\(location.latitude),\(location.longitude)"
        locationManager.stopUpdatingLocation()
        
        let nearbyEventsString = "http://api.eventful.com/json/events/search?app_key=PG3Hqs9jcxdxLWmk&page_size=20&location=\(self.userLocationCoordinates!)" + "&within=10&units=miles&date=future&sort_order=popularity&image_sizes=perspectivecrop290by250"
        setURLToReload(urlString: nearbyEventsString)
        reloadURL(urlString: nearbyEventsString, sortByDate: true)
    }
    
    func reloadURL(urlString: String, sortByDate: Bool) {        
        if EventViewController.loadActivityController {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityIndicator?.center = tableView.center
            activityIndicator?.color = .dtwFadedRed
            view.addSubview(activityIndicator!)
            activityIndicator?.startAnimating()
            EventViewController.loadActivityController = false
        }
        
        if let url = URL(string: urlString) {
            EventfulManager.getDataFromAPI(url: url, completion: { (events: ([Event]?)) in
                if let events = events {
                    self.activityIndicator?.stopAnimating()
                    self.activityIndicator?.removeFromSuperview()
                    self.eventsList = events
                    self.tableView.reloadData()
                }
                
                if self.eventsList.count == 0 {
                    let nothingInTableLabel = UILabel(frame: CGRect(x: 0, y: self.headerView.frame.maxY, width: self.view.frame.width, height: 400))
                    nothingInTableLabel.text = "No events match your search. Try again with fewer filters."
                    nothingInTableLabel.backgroundColor = .dtwPaleGrey
                    nothingInTableLabel.font = UIFont.dtw16DarkGrayRegularFont()
                    nothingInTableLabel.textColor = .dtwSlateGrey
                    nothingInTableLabel.numberOfLines = 2
                    nothingInTableLabel.textAlignment = .center
                    self.tableView.backgroundView = nothingInTableLabel
                }
                
                if sortByDate {
                    self.eventsList.sort(by: { (event1, event2) -> Bool in
                        if event1.eventStartTime < event2.eventStartTime {
                            return true
                        }
                        else {
                            return false
                        }
                    })
                }
            })
            
        }
    }
    
    func setURLToReload(urlString: String) {
        URLToReload = urlString
    }
    
    func setTagsArray(tagList: [String]) {
        self.tagLabelArray = tagList
    }
    
    func setTagsDisplay(buttonList: [String]) {
        if buttonList.count > 0 {
            headerView.frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: view.frame.height * 127/603)
            headerViewLineLabel.frame = CGRect(x: 0, y: headerView.frame.height - 0.5, width: view.frame.width, height: 0.5)
            tableView.frame = CGRect(x: 0, y: headerView.frame.maxY, width: view.frame.width, height: view.frame.height - self.headerView.frame.maxY)
            filterButton.setTitle("Edit Filters", for: .normal)
            filterButton.frame = CGRect(x: view.frame.width * 295/375, y: view.frame.height * 15/603, width: 68, height: 19)
            filterButton.setTitleColor(.dtwCoolGrey, for: .normal)
            var xSpacing: CGFloat = 12
            for tagName in buttonList {
                let tagLabel = UILabel(frame: CGRect(x: xSpacing, y: view.frame.height * 85/603, width: 113, height: 30))
                tagLabel.text = tagName
                tagLabel.textColor = .white
                tagLabel.backgroundColor = UIColor.dtwFadedRed
                tagLabel.textAlignment = .center
                tagLabel.font = UIFont.dtw14WhiteRegularFont()
                tagLabel.isUserInteractionEnabled = false
                xSpacing = tagLabel.frame.maxX + 6
                tagUILabelArray.append(tagLabel)
                headerView.addSubview(tagLabel)
            }
        }
    }

    func setDateDistance(date: String, distance: String) {
        dateString = date
        distanceString = distance
    }

    func setDateDistanceLabels(date: String, distance: String) {
        if date != "" && distance != "" {
            headerView.frame = CGRect(x: 0, y: view.frame.height * 64/603, width: self.view.frame.width, height: 86)
            headerViewLineLabel.frame = CGRect(x: 0, y: headerView.frame.height - 0.5, width: view.frame.width, height: 0.5)
            tableView.frame = CGRect(x: 0, y: headerView.frame.maxY, width: view.frame.width, height: view.frame.height - self.headerView.frame.maxY)
            dateLabel.frame = CGRect(x: view.frame.width * 12/375, y: view.frame.height * 47/603, width: 144, height: 24)
            dateLabel.backgroundColor = .white
            dateLabel.text = date
            dateLabel.textColor = .dtwSlateGrey
            dateLabel.font = UIFont.dtw14DarkGrayLightFont()
            
            dateLineLabel.frame = CGRect(x: view.frame.width * 12/375, y: dateLabel.frame.maxY, width: 144, height: 1)
            dateLineLabel.backgroundColor = .dtwSilver
            
            distanceLabel.frame = CGRect(x: view.frame.width * 187.5/375, y: view.frame.height * 47/603, width: 144, height: 24)
            distanceLabel.backgroundColor = .white
            distanceLabel.font = UIFont.dtw14DarkGrayLightFont()
            distanceLabel.text = distance
            distanceLabel.textColor = .dtwSlateGrey
            
            distanceLineLabel.frame = CGRect(x: view.frame.width * 187.5/375, y: distanceLabel.frame.maxY, width: 144, height: 1)
            distanceLineLabel.backgroundColor = .dtwSilver
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse") as? EventTableViewCell {
            let event = eventsList[indexPath.row]
            cell.setup(eventImage: EventfulManager.getImageFromURLString(urlString: event.imageURL), eventTitle: event.eventTitle, eventDescription: event.eventDescription, eventStartTime: event.eventStartTime, eventStopTime: event.eventEndTime, venue: event.venueName, id: event.eventID)
            return cell
        }
        
        return EventTableViewCell(style: .default, reuseIdentifier: "Reuse")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = eventsList[indexPath.row]
        
        let eventDetailViewController = EventDetailViewController()
        eventDetailViewController.event = event
        eventDetailViewController.eventID = event.eventID
        
        navigationController?.pushViewController(eventDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !(indexPath.row + 1 < eventsList.count) {
            EventViewController.loadActivityController = true
            if EventViewController.loadActivityController {
                activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                activityIndicator?.center = tableView.center
                activityIndicator?.color = .dtwFadedRed
                view.addSubview(activityIndicator!)
                activityIndicator?.startAnimating()
                EventViewController.loadActivityController = false
            }
            pageNumber += 1
            let displayNextPageURL = "\(URLToReload)&page_number=\(pageNumber)"
            if let url = URL(string: displayNextPageURL) {
                EventfulManager.getDataFromAPI(url: url, completion: { (events: ([Event]?)) in
                    var eventsToAppend = [Event]()
                    if let events = events {
                        eventsToAppend = events
                    }
                    
                    for event in eventsToAppend {
                        self.eventsList.append(event)
                        self.activityIndicator?.stopAnimating()
                        self.activityIndicator?.removeFromSuperview()
                    }
                    self.tableView.reloadData()
                })
            }
        }
        
    }
    
}

