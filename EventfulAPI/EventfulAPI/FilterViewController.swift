//
//  FilterViewController.swift
//  EventfulAPI
//
//  Created by Mindy Lou on 1/27/17.
//  Copyright © 2017 Mindy Lou. All rights reserved.
//

import UIKit
import DropDown

class FilterViewController: UIViewController {

    var scrollView: UIScrollView!
    var dateFilterLabel: UILabel!
    var dateFilterDropdownButton: UIButton!
    var distanceFilterLabel: UILabel!
    var distanceFilterDropdownButton: UIButton!
    var dateDropdown: DropDown!
    var distanceDropdown: DropDown!
    var dateDistanceSectionLineLabel: UILabel!
    var sortByLabel: UILabel!
    var dateButton: UIButton!
    var distanceButton: UIButton!
    var popularityButton: UIButton!
    var sortBySectionLineLabel: UILabel!
    var tagFilterLabel: UILabel!
    var filterButton: UIButton!
    
    var tagButtonList: [UIButton]! = []
    
    var buttonPadding: CGFloat!
    var buttonWidth: CGFloat!
    var buttonHeight: CGFloat!
    var leadingPadding: CGFloat!
    
    var userLocationCoordinates: String!
    var eventfulString: String!
    
    var tagsToDisplay = [String]()
    
    var delegate: ReloadEventViewControllerDelegate?
    
    let tagsList: [String] = [
        "music",
        "conference",
        "comedy",
        "education",
        "family",
        "festivals",
        "movies_film",
        "food",
        "fundraisers",
        "art",
        "support",
        "holiday",
        "books",
        "attractions",
        "community",
        "business",
        "singles_social",
        "schools",
        "clubs",
        "outdoors",
        "performing",
        "animals",
        "politics",
        "sales",
        "science",
        "religion",
        "sports",
        "technology",
        "other"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        DropDown.startListeningToKeyboard()
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.leftBarButtonItem?.title = ""
        navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .white
        navigationItem.title = "Filter"
        
        layoutSubviews()
    }
    
    func layoutSubviews() {
        scrollView = UIScrollView(frame: view.frame)
        scrollView.backgroundColor = .white
        scrollView.alwaysBounceVertical = true
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 1.2)
        
        setupDateDistanceFilters()
        
        buttonPadding = 6/375 * view.frame.width
        buttonWidth = 113/375 * view.frame.width
        buttonHeight = 30/603 * view.frame.height
        leadingPadding = 12/375 * view.frame.width
        
        setupSortByButtons()
        
        setupTagButtons()
        
        view.addSubview(scrollView)
        
        filterButton = UIButton(frame: CGRect(x: 0, y: view.frame.height - 36, width: view.frame.width, height: 36))
        filterButton.backgroundColor = UIColor.dtwFadedRed85
        filterButton.titleLabel?.font = UIFont.dtw16WhiteRegularFont()
        filterButton.titleLabel?.textAlignment = .center
        filterButton.setTitle("Filter", for: .normal)
        filterButton.setTitleColor(.white, for: .normal)
        filterButton.addTarget(self, action: #selector(filterEvents), for: .touchUpInside)
        view.addSubview(filterButton)
        
    }
    
    func filterEvents() {
        var shouldSortByDate: Bool = false
        eventfulString = "http://api.eventful.com/json/events/search?app_key=PG3Hqs9jcxdxLWmk&page_size=20&location=" + self.userLocationCoordinates
        if dateFilterDropdownButton.titleLabel?.text == "Today" {
            eventfulString = eventfulString + "&date=today"
        } else if dateFilterDropdownButton.titleLabel?.text == "Next Week" {
            eventfulString = eventfulString + "&date=next_week"
        } else if dateFilterDropdownButton.titleLabel?.text == "This Month" {
            eventfulString = eventfulString + "&date=this_month"
        }
        if distanceFilterDropdownButton.titleLabel?.text == "<5 Miles" {
            eventfulString = eventfulString + "&within=5&units=miles"
        } else if distanceFilterDropdownButton.titleLabel?.text == "<10 Miles" {
            eventfulString = eventfulString + "&within=10&units=miles"
        } else if distanceFilterDropdownButton.titleLabel?.text == "<20 Miles" {
            eventfulString = eventfulString + "&within=20&units=miles"
        }
        if dateButton.isSelected {
            eventfulString = eventfulString + "&sort_order=relevance"
            shouldSortByDate = true
        }
        if distanceButton.isSelected {
            eventfulString = eventfulString + "&sort_order=distance"
        }
        if popularityButton.isSelected {
            eventfulString = eventfulString + "&sort_order=popularity"
        }
        
        var tagString = "&category="
        
        for tagButton in tagButtonList {
            if tagButton.isSelected {
                if let title = tagButton.titleLabel?.text {
                    tagsToDisplay.append(title)
                    let titleNoHashtag = title.substring(from: title.index(title.startIndex, offsetBy: 1))
                    tagString = tagString + titleNoHashtag + ","
                }
            }
        }
        
        eventfulString = eventfulString + tagString + "&image_sizes=perspectivecrop290by250"
        EventViewController.loadActivityController = true
        delegate?.reloadURL(urlString: eventfulString, sortByDate: shouldSortByDate)
        delegate?.setURLToReload(urlString: eventfulString)
        delegate?.setTagsArray(tagList: tagsToDisplay)
        if let date = dateFilterDropdownButton.titleLabel?.text, let distance = distanceFilterDropdownButton.titleLabel?.text {
            delegate?.setDateDistance(date: date, distance: distance)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    func setupDateDistanceFilters() {
        dateFilterLabel = UILabel(frame: CGRect(x: view.frame.width * 12/375, y: view.frame.height * 13/603, width: 35.5, height: 22))
        dateFilterLabel.font = UIFont.dtw16RedRegularFont()
        dateFilterLabel.textColor = .dtwFadedRed
        dateFilterLabel.text = "Date"
        
        distanceFilterLabel = UILabel(frame: CGRect(x: view.frame.width * 187.5/375, y: view.frame.height * 13/603, width: 64, height: 22))
        distanceFilterLabel.font = UIFont.dtw16RedRegularFont()
        distanceFilterLabel.textColor = .dtwFadedRed
        distanceFilterLabel.text = "Distance"
        
        scrollView.addSubview(dateFilterLabel)
        scrollView.addSubview(distanceFilterLabel)
        
        dateFilterDropdownButton = UIButton(frame: CGRect(x: 12, y: dateFilterLabel.frame.maxY, width: view.frame.width/2, height: view.frame.height/20))
        dateFilterDropdownButton.setTitle("Today", for: .normal)
        dateFilterDropdownButton.titleLabel?.font = UIFont.dtw14DarkGrayLightFont()
        dateFilterDropdownButton.setTitleColor(.dtwSlateGrey, for: .normal)
        dateFilterDropdownButton.contentHorizontalAlignment = .left
        dateDropdown = DropDown()
        dateDropdown.anchorView = dateFilterDropdownButton
        dateDropdown.dataSource = [
            "Today",
            "Next Week",
            "This Month"
        ]
        dateDropdown.dismissMode = .automatic
        dateDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dateFilterDropdownButton.setTitle(item, for: .normal)
        }
        dateFilterDropdownButton.addTarget(self, action: #selector(showDateDropdown), for: .touchUpInside)
        scrollView.addSubview(dateFilterDropdownButton)
        
        distanceFilterDropdownButton = UIButton(frame: CGRect(x: view.frame.width/2, y:
            distanceFilterLabel.frame.maxY, width: view.frame.width/2, height: view.frame.height/20))
        distanceFilterDropdownButton.setTitle("<10 Miles", for: .normal)
        distanceFilterDropdownButton.titleLabel?.font = UIFont.dtw14DarkGrayLightFont()
        distanceFilterDropdownButton.setTitleColor(.dtwSlateGrey, for: .normal)
        distanceFilterDropdownButton.contentHorizontalAlignment = .left
        distanceDropdown = DropDown()
        distanceDropdown.anchorView = distanceFilterDropdownButton
        distanceDropdown.dataSource = [
            "<5 Miles",
            "<10 Miles",
            "<20 Miles"
        ]
        distanceDropdown.dismissMode = .automatic
        distanceDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.distanceFilterDropdownButton.setTitle(item, for: .normal)
        }
        distanceFilterDropdownButton.addTarget(self, action: #selector(showDistanceDropdown), for: .touchUpInside)
        scrollView.addSubview(distanceFilterDropdownButton)
        
        let dateFilterLineLabel = UILabel(frame: CGRect(x: view.frame.width * 12/375, y: dateFilterDropdownButton.frame.maxY + 6, width: 144, height: 1))
        dateFilterLineLabel.backgroundColor = .dtwSilver
        scrollView.addSubview(dateFilterLineLabel)
        
        let distanceFilterLineLabel = UILabel(frame: CGRect(x: view.frame.width * 187.5/375, y: distanceFilterDropdownButton.frame.maxY + 6, width: 144, height: 1))
        distanceFilterLineLabel.backgroundColor = .dtwSilver
        scrollView.addSubview(distanceFilterLineLabel)
        
        dateDistanceSectionLineLabel = UILabel(frame: CGRect(x: 0, y: view.frame.height * 85/603, width: view.frame.width, height: 1))
        dateDistanceSectionLineLabel.backgroundColor = .dtwPaleGrey
        scrollView.addSubview(dateDistanceSectionLineLabel)
    }
    
    func setupSortByButtons() {
        sortByLabel = UILabel(frame: CGRect(x: 12, y: dateDistanceSectionLineLabel.frame.maxY + 13, width: view.frame.width, height: view.frame.height/20))
        sortByLabel.font = UIFont.dtw16RedRegularFont()
        sortByLabel.textColor = .dtwFadedRed
        sortByLabel.text = "Sort by"
        scrollView.addSubview(sortByLabel)
        
        dateButton = UIButton(frame: CGRect(x: leadingPadding, y: sortByLabel.frame.maxY + 12, width: buttonWidth, height: buttonHeight))
        dateButton.backgroundColor = UIColor.dtwPaleGrey
        dateButton.setTitle("Date", for: .normal)
        dateButton.titleLabel?.font = UIFont.dtw14DarkGrayRegularFont()
        dateButton.setTitleColor(.dtwSlateGrey, for: .normal)
        dateButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        dateButton.tag = 0
        scrollView.addSubview(dateButton)
        
        distanceButton = UIButton(frame: CGRect(x: buttonPadding + dateButton.frame.maxX, y: sortByLabel.frame.maxY + 12, width: buttonWidth, height: buttonHeight))
        distanceButton.backgroundColor = .dtwPaleGrey
        distanceButton.setTitle("Distance", for: .normal)
        distanceButton.titleLabel?.font = UIFont.dtw14DarkGrayRegularFont()
        distanceButton.setTitleColor(.dtwSlateGrey, for: .normal)
        distanceButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        distanceButton.tag = 0
        scrollView.addSubview(distanceButton)
        
        popularityButton = UIButton(frame: CGRect(x: buttonPadding + distanceButton.frame.maxX, y: sortByLabel.frame.maxY + 12, width: buttonWidth, height: buttonHeight))
        popularityButton.backgroundColor = .dtwPaleGrey
        popularityButton.setTitle("Popularity", for: .normal)
        popularityButton.titleLabel?.font = .dtw14DarkGrayRegularFont()
        popularityButton.setTitleColor(.dtwSlateGrey, for: .normal)
        popularityButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        popularityButton.tag = 0
        scrollView.addSubview(popularityButton)
        
        sortBySectionLineLabel = UILabel(frame: CGRect(x: 0, y: dateButton.frame.maxY + 12, width: view.frame.width, height: 1))
        sortBySectionLineLabel.backgroundColor = .dtwPaleGrey
        scrollView.addSubview(sortBySectionLineLabel)
    }

    func setupTagButtons() {
        tagFilterLabel = UILabel(frame: CGRect(x: 12, y: sortBySectionLineLabel.frame.maxY + 12, width: view.frame.width, height: 22))
        tagFilterLabel.font = UIFont.dtw16RedRegularFont()
        tagFilterLabel.textColor = .dtwFadedRed
        tagFilterLabel.text = "Tags"
        scrollView.addSubview(tagFilterLabel)
        
        for index in 0...tagsList.count-1 {
            var xPadding: CGFloat = 0
            let yPadding = CGFloat(index/3 * Int((buttonPadding + buttonHeight))) + 12
            
            if index % 3 == 0 {
                xPadding = leadingPadding
            } else if index % 3 == 1 {
                xPadding = leadingPadding + buttonWidth
                xPadding = xPadding + buttonPadding
            } else if index % 3 == 2 {
                xPadding = leadingPadding + 2 * buttonPadding + 2 * buttonWidth
            }
            
            let tagButton = UIButton(frame: CGRect(x: xPadding, y: yPadding + tagFilterLabel.frame.maxY, width: buttonWidth, height: buttonHeight))
            tagButton.backgroundColor = .dtwPaleGrey
            tagButton.setTitle("#" + tagsList[index], for: .normal)
            tagButton.titleLabel?.font = UIFont.dtw14DarkGrayRegularFont()
            tagButton.setTitleColor(.dtwSlateGrey, for: .normal)
            tagButton.tag = 2
            tagButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            tagButtonList.append(tagButton)
            scrollView.addSubview(tagButton)
        }
        
        let clearTagButton = UIButton(frame: CGRect(x: view.frame.width * 293/375, y: sortBySectionLineLabel.frame.maxY + view.frame.height * 14.5/603, width: 70, height: 17))
        clearTagButton.setTitle("Clear Tags", for: .normal)
        clearTagButton.setTitleColor(.dtwCoolGrey, for: .normal)
        clearTagButton.titleLabel?.font = .dtw14LightGrayRegularFont()
        clearTagButton.titleLabel?.textAlignment = .right
        clearTagButton.addTarget(self, action: #selector(clearTagButtons), for: .touchUpInside)
        scrollView.addSubview(clearTagButton)
        
    }
    
    func buttonTapped(sender: UIButton) {
        if sender.tag >= 0 {
            if sender.isSelected {
                sender.isSelected = false
                sender.backgroundColor = .dtwPaleGrey
                sender.titleLabel?.font = UIFont.dtw14DarkGrayRegularFont()
                sender.setTitleColor(.dtwSlateGrey, for: .normal)
            } else {
                sender.isSelected = true
                sender.backgroundColor = .dtwFadedRed
                sender.titleLabel?.font = UIFont.dtw14WhiteRegularFont()
                sender.setTitleColor(.white, for: .normal)
            }
            
        }
    }
    
    func clearTagButtons() {
        for button in tagButtonList {
            if button.isSelected {
                button.isSelected = false
                button.backgroundColor = .dtwPaleGrey
                button.titleLabel?.font = UIFont.dtw14DarkGrayRegularFont()
                button.setTitleColor(.dtwSlateGrey, for: .normal)
            }
        }
    }
    
    func showDateDropdown() {
        dateDropdown.show()
    }
    
    func showDistanceDropdown() {
        distanceDropdown.show()
    }


}
