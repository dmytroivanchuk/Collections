//
//  SetViewController.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 15.08.2022.
//

import UIKit

class SetViewController: UIViewController {

    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    
    
    @IBOutlet var matchingCharactersLabel: UILabel!
    @IBOutlet var nonMatchingCharactersLabel: UILabel!
    @IBOutlet var uniqueCharactersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @IBAction func matchingCharatersButtonPressed(_ sender: UIButton) {
    }
    @IBAction func nonMatchingCharactersButtonPressed(_ sender: UIButton) {
    }
    @IBAction func uniqueCharactersButtonPressed(_ sender: UIButton) {
    }
}
