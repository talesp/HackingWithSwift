//
//  ViewController.swift
//  WordScramble
//
//  Created by Tales Pinheiro De Andrade on 09/09/17.
//  Copyright © 2017 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var allWords = [String]()
    var usedWords = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()

        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                allWords = startWords.components(separatedBy: "\n")
            }
            else {
                allWords = ["silkworm"]
            }
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(promptForAnswer))

        startGame()

    }

    @objc func promptForAnswer() {

        let alertController = UIAlertController(title: "Enter new Answer:",
                                               message: nil,
                                               preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, alertController] _ in
            let answer = alertController.textFields![0]
            self.submit(answer: answer.text!)
        }

        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }

    func submit(answer: String) {

        func isPossible(word: String) -> Bool {
            var tempWord = title!.lowercased()

            for letter in word.characters {
                if let pos = tempWord.range(of: String(letter)) {
                    tempWord.remove(at: pos.lowerBound)
                }
                else {
                    return false
                }
            }
            return true
        }

        func isOriginal(word: String) -> Bool {
            return !usedWords.contains(word)
        }

        func isReal(word: String) -> Bool {
            let checker = UITextChecker()
            let range = NSMakeRange(0, word.utf16.count)
            let misspeledRange = checker.rangeOfMisspelledWord(in: word,
                                                               range: range,
                                                               startingAt: 0,
                                                               wrap: false,
                                                               language: "en")
            return misspeledRange.location == NSNotFound
        }

        let lowerAnswer = answer.lowercased()
        let errorTitle: String
        let errorMessage: String
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                }
                else {
                    errorTitle = "Word not recognized"
                    errorMessage = "You can't just make them up, you know!"
                }
            }
            else {
                errorTitle = "Word used already"
                errorMessage = "Me more original"
            }
        }
        else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from '\(title!.lowercased())'"
        }

        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

    func startGame() {
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        title = allWords[0]
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {

}
