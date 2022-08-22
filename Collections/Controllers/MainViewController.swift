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
        if segue.identifier == "mainToArrayScreenSegue" {
            let destinationVC = segue.destination as? ArrayViewController
            destinationVC?.title = "Array: \(Int.random(in: 0 ..< 10_000))"
        
        } else if segue.identifier == "mainToSetScreenSegue" {
            let destinationVC = segue.destination as? SetViewController
            destinationVC?.title = "Set: \(Int.random(in: 0 ..< 10_000))"
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        (sender as! UITableViewCell) == menuTableView.cellForRow(at: IndexPath(row: 0, section: 0)) ? true : false
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
