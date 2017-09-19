//
//  ViewController.swift
//  AutoLayout
//
//  Created by Tales Pinheiro De Andrade on 16/09/17.
//  Copyright © 2017 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco",
                     "nigeria", "poland", "russia", "spain", "uk", "us"]
    var score = 0
    var correctAnswer = 0
    
    @IBAction func buttonTapped(_ sender: Any) {

        var title: String

        if (sender as AnyObject).tag == correctAnswer {
            title = "Correct"
            score += 1
        }
        else {
            title = "Wrong"
            score -= 1
        }

        let alertController = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(alertController, animated: true, completion: nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        button1.layer.borderWidth = 1.0
        button2.layer.borderWidth = 1.0
        button3.layer.borderWidth = 1.0

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion(action: nil)
    }

    func askQuestion(action: UIAlertAction!) {

        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]

        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        title = countries[correctAnswer].uppercased()

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

