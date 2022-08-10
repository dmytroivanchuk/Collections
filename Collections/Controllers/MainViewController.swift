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
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
}

//MARK: - UITableViewDelegate Methods

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

//MARK: - UITableViewDataSource Methods

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
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
