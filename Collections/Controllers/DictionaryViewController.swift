//
//  DictionaryViewController.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 18.08.2022.
//

import UIKit

class DictionaryViewController: UIViewController {

    @IBOutlet var dictionaryCollectionView: UICollectionView!
    @IBOutlet weak var dictionaryCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var operationInProcessActivityIndicatorView: UIActivityIndicatorView!
    
    let dictionaryProcessingModel = DictionaryProcessingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        dictionaryCollectionView.dataSource = self
        dictionaryCollectionView.delegate = self
        dictionaryCollectionView.register(UINib(nibName: "OperationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OperationCollectionViewCell")
        
        operationInProcessActivityIndicatorView.hidesWhenStopped = true
        
        dictionaryProcessingModel.generateDictionaryArray {
            self.dictionaryCollectionView.reloadData()
            self.dictionaryCollectionViewHeightConstraint.constant = self.dictionaryCollectionView.collectionViewLayout.collectionViewContentSize.height
            self.view.layoutIfNeeded()
            self.operationInProcessActivityIndicatorView.stopAnimating()
        }
        operationInProcessActivityIndicatorView.startAnimating()
    }
}

//MARK: - UICollectionViewDelegate Methods

extension DictionaryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if indexPath.section != 0 {
            let operation = dictionaryProcessingModel.dictionaryOperations[indexPath.item]
            guard operation.status == .idle else {
                return
            }
            
            dictionaryProcessingModel.executeOperation(operation) {
                collectionView.reloadItems(at: [indexPath])
            }
            collectionView.reloadItems(at: [indexPath])
        }
    }
}

//MARK: - UICollectionViewDataSource Methods

extension DictionaryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dictionaryProcessingModel.dictionaryGenerationStatus == .idle || dictionaryProcessingModel.dictionaryGenerationStatus == .executing ? 0 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 2 : dictionaryProcessingModel.dictionaryOperations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dictionaryCollectionView.dequeueReusableCell(withReuseIdentifier: "OperationCollectionViewCell", for: indexPath) as! OperationCollectionViewCell
        collectionView.backgroundColor = .systemGray3
        cell.operationDescriptionLabel.textAlignment = .center
        
        if indexPath.section == 0 {
            cell.operationDescriptionLabel.text = indexPath.item == 0 ? "Array" : "Dictionary"
            cell.operationDescriptionLabel.textColor = .label
            cell.operationView.backgroundColor = .systemBackground
        
        } else if indexPath.section == 1 {
            let operation = dictionaryProcessingModel.dictionaryOperations[indexPath.item]
            
            switch operation.status {
            case .idle:
                cell.operationDescriptionLabel.text = operation.description
            case .executing:
                cell.operationDescriptionLabel.text = ""
                cell.operationInProcessActivityIndicatorView.startAnimating()
            case let .finished(executionTime, resultNumber):
                cell.operationDescriptionLabel.text = "Search time: \(String(format: "%.2f", executionTime)) s. Result number: \(resultNumber)"
                cell.operationView.backgroundColor = UIColor(named: "customLightGray")
            }
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout Methods

extension DictionaryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: (collectionView.frame.width) / 2, height: 50)
        default:
            return CGSize(width: (collectionView.frame.width - 1) / 2, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        section == 0 ? UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0) : UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        section == 0 ? CGFloat(0) : CGFloat(1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        CGFloat(1)
    }
}
