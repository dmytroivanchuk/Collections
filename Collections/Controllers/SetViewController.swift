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
    
    let setProcessingModel = SetProcessingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        firstTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        secondTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        firstTextField.accessibilityIdentifier = "firstTextField"
        secondTextField.accessibilityIdentifier = "secondTextField"
    }
    
    @IBAction func matchingCharatersButtonPressed(_ sender: UIButton) {
        matchingCharactersLabel.text = setProcessingModel.executeOperation(withIdentifier: OperationIdentifier.matchingCharacters, firstTextField.text, secondTextField.text)
    }
    @IBAction func nonMatchingCharactersButtonPressed(_ sender: UIButton) {
        nonMatchingCharactersLabel.text = setProcessingModel.executeOperation(withIdentifier: OperationIdentifier.nonMatchingCharacters, firstTextField.text, secondTextField.text)
    }
    @IBAction func uniqueCharactersButtonPressed(_ sender: UIButton) {
        uniqueCharactersLabel.text = setProcessingModel.executeOperation(withIdentifier: OperationIdentifier.uniqueCharacters, firstTextField.text, secondTextField.text)
    }
    
    //MARK: - UITextField Methods
    
    @objc func textFieldDidChange(textField: UITextField) {
        if let input = textField.text {
            textField.text = input.filter { $0.isLetter }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
