//
//  ViewController.swift
//  StormViewer
//
//  Created by Tales Pinheiro De Andrade on 02/09/17.
//  Copyright © 2017 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"
        
        let fileManager = FileManager.default
        guard let path = Bundle.main.resourcePath else { return }
        do {
            let items = try fileManager.contentsOfDirectory(atPath: path)
                .filter({$0.hasPrefix("nssl")})
            pictures.append(contentsOf: items)
        }
        catch let e {
            dump(e)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewcontroller = self.storyboard?
            .instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
        viewcontroller.selectedImage = pictures[indexPath.row]
        self.show(viewcontroller, sender: self)
    }
}
