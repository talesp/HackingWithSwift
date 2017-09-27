//
//  ViewController.swift
//  AutoLayoutInCode
//
//  Created by Tales Pinheiro De Andrade on 24/09/17.
//  Copyright © 2017 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "THESE"

        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"

        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"

        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"

        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"

        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)

        let viewsDictionary = [
            "label1": label1,
            "label2": label2,
            "label3": label3,
            "label4": label4,
            "label5": label5
        ]


        for label in viewsDictionary.keys {
            view.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[\(label)]|",
                options: [],
                metrics: nil,
                views: viewsDictionary)
            )
        }

        let metrics = ["labelHeight": 88]
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[label1(==labelHeight@999)]-[label2(label1)]-[label3(label2)]-[label4(label3)]-[label5(label4)]-(>=10)-|",
            options: [],
            metrics: metrics,
            views: viewsDictionary)
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

