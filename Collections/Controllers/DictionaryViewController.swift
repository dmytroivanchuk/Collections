//
//  DictionaryViewController.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 18.08.2022.
//

import UIKit

class DictionaryViewController: UIViewController {

    @IBOutlet var dictionaryCollectionView: UICollectionView!
    @IBOutlet var operationInProcessActivityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
}
