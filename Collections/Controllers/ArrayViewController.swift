//
//  ArrayViewController.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 11.08.2022.
//

import UIKit

class ArrayViewController: UIViewController {

    @IBOutlet var arrayCollectionView: UICollectionView!
    
    let arrayProcessingModel = ArrayProcessingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        arrayCollectionView.delegate = self
        arrayCollectionView.dataSource = self
        arrayCollectionView.register(UINib(nibName: "OperationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OperationCollectionViewCell")
    }
}

//MARK: - UICollectionViewDelegate Methods

extension ArrayViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
            guard arrayProcessingModel.array.isEmpty else {
                return
            }
            arrayProcessingModel.generateArray {
                collectionView.reloadItems(at: [indexPath])
            } completion: {
                collectionView.reloadData()
            }
        
        } else if indexPath.section == 1 {
            
            let operation = arrayProcessingModel.arrayOperations[indexPath.item]
            guard operation.status == .idle else {
                return
            }
            
            arrayProcessingModel.executeOperation(operation) {
                collectionView.reloadItems(at: [indexPath])
            } completion: {
                collectionView.reloadItems(at: [indexPath])
            }
        }
    }
}

//MARK: - UICollectionViewDataSource Methods

extension ArrayViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        arrayProcessingModel.array.isEmpty ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 1 : arrayProcessingModel.arrayOperations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = arrayCollectionView.dequeueReusableCell(withReuseIdentifier: "OperationCollectionViewCell", for: indexPath) as! OperationCollectionViewCell
        
        if indexPath.section == 0 {
            
            switch arrayProcessingModel.arrayGenerationStatus {
            case .idle:
                cell.operationDescriptionLabel.text = "Create Int array with 10_000_000 elements"
            case .executing:
                cell.operationInProcessActivityIndicatorView.startAnimating()
            case let .finished(executionTime):
                cell.operationDescriptionLabel.text = "Array generation time: \(String(format: "%.2f", executionTime))"
            }
        
        } else if indexPath.section == 1 {
            
            let operation = arrayProcessingModel.arrayOperations[indexPath.item]
            
            switch operation.status {
            case .idle:
                cell.operationDescriptionLabel.text = operation.description
            case .executing:
                cell.operationInProcessActivityIndicatorView.startAnimating()
            case let .finished(executionTime):
                cell.operationDescriptionLabel.text = "Execution time: \(String(format: "%.2f", executionTime))"
            }
        }
        
        return cell
    }
}
