//
//  ViewController.swift
//  WhitehousePetitions
//
//  Created by Tales Pinheiro De Andrade on 26/09/17.
//  Copyright © 2017 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [[String: String]]()

    func showError() {
        let alertController = UIAlertController(title: "Loading error", message: """
There was a problem loading the feed;
please check your connection and try again.
""", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        }
        else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }

        if let url = URL(string: urlString) {

            if let data = try? Data(contentsOf: url) {

                let json = JSON(data: data)

                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    parse(json: json)
                }
                else {
                    showError()
                }
            }
            else {
                showError()
            }
        }
        else {
            showError()
        }
    }

    func parse(json: JSON) {
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title": title, "body": body, "sigs": sigs]
            petitions.append(obj)
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        viewController.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]

        return cell
    }
}

