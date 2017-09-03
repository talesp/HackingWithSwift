//
//  DetailViewController.swift
//  SocialMedia
//
//  Created by Tales Pinheiro De Andrade on 03/09/17.
//  Copyright © 2017 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    var imageName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let filename = imageName else { return }
        imageView.image = UIImage(named: filename)
        title = filename
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }

    @objc func shareTapped() {
//        let viewController = UIActivityViewController(activityItems: [imageView.image!],
//                                                      applicationActivities: [])
//        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        self.present(viewController, animated: true, completion: nil)

        if let viewcontroller = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
            viewcontroller.setInitialText("Look this picture!")
            viewcontroller.add(imageView.image!)
            viewcontroller.add(URL(string: "http://www.photolib.noaa.bov/nssl"))
            self.present(viewcontroller, animated: true, completion: nil)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.hidesBarsOnTap = false
    }
}
