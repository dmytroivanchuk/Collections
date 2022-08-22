//
//  OperationCollectionViewCell.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 11.08.2022.
//

import UIKit

class OperationCollectionViewCell: UICollectionViewCell {

    @IBOutlet var operationView: UIView!
    @IBOutlet var operationDescriptionLabel: UILabel!
    @IBOutlet var operationInProcessActivityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        operationView.backgroundColor = UIColor(named: "customDarkGray")
        
        operationDescriptionLabel.text = ""
        operationDescriptionLabel.font = .systemFont(ofSize: 16)
        operationDescriptionLabel.textColor = .systemBlue
        operationDescriptionLabel.numberOfLines = 0
        
        operationInProcessActivityIndicatorView.hidesWhenStopped = true
    }
}
