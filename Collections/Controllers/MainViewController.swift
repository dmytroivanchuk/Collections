//
//  MainViewController.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 10.08.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var menuTableView: UITableView!
    
    let cellTitleArray = ["Array", "Set", "Dictionary"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Collections"
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? SetViewController
        destinationVC?.title = "Set: \(Int.random(in: 0 ..< 10_000))"
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let senderCell = sender as! UITableViewCell
        if identifier == "mainToArrayScreenSegue" {
            if senderCell.contentConfiguration.debugDescription.contains("Array") {
                return true
            } else {
                return false
            }
        }
        return true
    }
}

//MARK: - UITableViewDelegate Methods

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 1:
            performSegue(withIdentifier: "mainToSetScreenSegue", sender: self)
        case 2:
            let storyboard = UIStoryboard(name: "DictionaryScreen", bundle: nil)
            let dictionaryViewController = (storyboard.instantiateViewController(withIdentifier: "DictionaryViewController") as! DictionaryViewController)
            dictionaryViewController.title = "Dictionary: \(Int.random(in: 0 ..< 10_000))"
            navigationController?.pushViewController(dictionaryViewController, animated: true)
        default:
            break
        }
    }
}

//MARK: - UITableViewDataSource Methods

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = cellTitleArray[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = content
        return cell
    }
}
