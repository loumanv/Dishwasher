//
//  DishwasherCell.swift
//  Dishwashers
//
//  Created by Vasileios Loumanis on 20/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

class DishwasherCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.af_cancelImageRequest()
        imageView.layer.removeAllAnimations()
        imageView.image = nil
    }
}
