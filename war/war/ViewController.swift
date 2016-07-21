//
//  ViewController.swift
//  war
//
//  Created by Mindy Lou on 7/15/16.
//  Copyright © 2016 Mindy Lou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstCardImageView: UIImageView!
    @IBOutlet weak var secondCardImageView: UIImageView!
    @IBOutlet weak var playRoundButton: UIButton!
    
    var card_names:[String] = ["ace", "card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "jack", "queen", "king"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.playRoundButton.setTitle("Play", forState: UIControlState.Normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func playRoundTapped(sender: UIButton) {
        // Randomize each card and display it

        // Randomize number for first image view and display corresponding asset
        let random_number1 = Int(arc4random_uniform(UInt32(self.card_names.count)))
            //this casting is so irritating
        self.firstCardImageView.image = UIImage(named: self.card_names[random_number1])
        
        // Randomize number for second image view and display corresponding asset
        let random_number2 = Int(arc4random_uniform(UInt32(self.card_names.count)))
        self.secondCardImageView.image = UIImage(named: self.card_names[random_number2])
    }

}

