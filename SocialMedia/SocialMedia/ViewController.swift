//
//  ViewController.swift
//  SocialMedia
//
//  Created by Tales Pinheiro De Andrade on 03/09/17.
//  Copyright © 2017 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var filenames: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            guard let path = Bundle.main.resourcePath else { return }
            let filenames = try FileManager
                .default
                .contentsOfDirectory(atPath: path)
                .filter({ $0.hasPrefix("nssl")})
            self.filenames = filenames
        }
        catch let e {
            dump(e)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell,
            let indexPath = self.tableView.indexPath(for: cell) else { return }
        let viewController = segue.destination as! DetailViewController
        viewController.imageName = self.filenames[indexPath.row]
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filenames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filenames[indexPath.row]
        return cell
    }
}
