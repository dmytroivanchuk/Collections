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
        let destinationVC = segue.destination as? ArrayViewController
        destinationVC?.title = "Array: \(Int.random(in: 0..<10_000))"
    }
}

//MARK: - UITableViewDelegate Methods

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
            case 0:
                performSegue(withIdentifier: "mainToArrayScreenSegue", sender: self)
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
