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
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    
    var player1Score:Int = 0
    var player2Score:Int = 0
    
    var card_names:[String] = ["card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "jack", "queen", "king", "ace"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func playRoundTapped(_ sender: UIButton) {
        // Randomize each card and display it

        // Randomize number for first image view and display corresponding asset
        let random_number1 = Int(arc4random_uniform(UInt32(self.card_names.count)))
        self.firstCardImageView.image = UIImage(named: self.card_names[random_number1])
        
        // Randomize number for second image view and display corresponding asset
        let random_number2 = Int(arc4random_uniform(UInt32(self.card_names.count)))
        self.secondCardImageView.image = UIImage(named: self.card_names[random_number2])
        
        // Determine the higher card and update the view
        if random_number1 > random_number2 {
            
            self.player1Score += 1
            player1ScoreLabel.text = String(player1Score)

        }
        else if random_number1 == random_number2 {
            self.player1Score = 0
            player1ScoreLabel.text = String(player1Score)
            self.player2Score = 0
            player2ScoreLabel.text = String(player2Score)

            
        }
        else {
            
            self.player2Score += 1
            player2ScoreLabel.text = String(player2Score)
        }
    }

}

