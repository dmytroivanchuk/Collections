//
//  ArrayViewController.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 11.08.2022.
//

import UIKit

class ArrayViewController: UIViewController {

    @IBOutlet var arrayCollectionView: UICollectionView!
    @IBOutlet var arrayCollectionViewHeightConstraint: NSLayoutConstraint!
    
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
            
            guard arrayProcessingModel.arrayGenerationStatus == .idle else {
                return
            }
            arrayProcessingModel.generateArray {
                collectionView.reloadData()
                self.arrayCollectionViewHeightConstraint.constant = self.arrayCollectionView.collectionViewLayout.collectionViewContentSize.height
                self.view.layoutIfNeeded()
            }
            collectionView.reloadItems(at: [indexPath])
            
        } else if indexPath.section == 1 {
            
            let operation = arrayProcessingModel.arrayOperations[indexPath.item]
            guard operation.status == .idle else {
                return
            }
            
            arrayProcessingModel.executeOperation(operation) {
                collectionView.reloadItems(at: [indexPath])
            }
            collectionView.reloadItems(at: [indexPath])
        }
    }
}

//MARK: - UICollectionViewDataSource Methods

extension ArrayViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        arrayProcessingModel.arrayGenerationStatus == .idle || arrayProcessingModel.arrayGenerationStatus == .executing ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 1 : arrayProcessingModel.arrayOperations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = arrayCollectionView.dequeueReusableCell(withReuseIdentifier: "OperationCollectionViewCell", for: indexPath) as! OperationCollectionViewCell
        
        if indexPath.section == 0 {
            cell.operationDescriptionLabel.textAlignment = .center
            
            switch arrayProcessingModel.arrayGenerationStatus {
            case .idle:
                cell.operationDescriptionLabel.text = "Create Int array with 10_000_000 elements"
            case .executing:
                cell.operationInProcessActivityIndicatorView.startAnimating()
            case let .finished(executionTime):
                cell.operationDescriptionLabel.text = "Array generation time: \(String(format: "%.2f", executionTime)) s."
                cell.operationView.backgroundColor = UIColor(named: "customLightGray")
                collectionView.backgroundColor = .systemGray3
            }
        
        } else if indexPath.section == 1 {
            cell.operationDescriptionLabel.textAlignment = .natural
            
            let operation = arrayProcessingModel.arrayOperations[indexPath.item]
            switch operation.status {
            case .idle:
                cell.operationDescriptionLabel.text = operation.description
            case .executing:
                cell.operationDescriptionLabel.text = ""
                cell.operationInProcessActivityIndicatorView.startAnimating()
            case let .finished(executionTime):
                cell.operationDescriptionLabel.text = "Execution time: \(String(format: "%.2f", executionTime)) s."
                cell.operationView.backgroundColor = UIColor(named: "customLightGray")
            }
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout Methods

extension ArrayViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
            case 0:
            return CGSize(width: collectionView.frame.width, height: 100)
            default:
            return CGSize(width: (collectionView.frame.width - 1) / 2, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        section == 0 ? UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0) : UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        CGFloat(1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        CGFloat(1)
    }
}
