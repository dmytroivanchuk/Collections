//
//  OperationCollectionViewCell.swift
//  Collections
//
//  Created by Dmytro Ivanchuk on 11.08.2022.
//

import UIKit

class OperationCollectionViewCell: UICollectionViewCell {

    @IBOutlet var operationDescriptionLabel: UILabel!
    @IBOutlet var operationProccessingActivityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
