//
//  CustomCell.swift
//  Carousel
//
//  Created by Артем Иревлин on 25.06.2021.
//

import UIKit

class CustomCell: UICollectionViewCell {

    @IBOutlet var imageCustomCell: UIImageView!
    @IBOutlet var labelCustomCell: UILabel!
    @IBOutlet var viewCustomCell: UIView!

    var interest: Service! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let interest = interest {
            imageCustomCell.image = interest.image
            labelCustomCell.text = interest.title
            viewCustomCell.backgroundColor = interest.color
        
        } else {
            imageCustomCell.image = nil
            labelCustomCell.text = nil
            viewCustomCell.backgroundColor = nil
        }
        viewCustomCell.layer.cornerRadius = 10.0
        viewCustomCell.layer.masksToBounds = true
        imageCustomCell.layer.cornerRadius = 10.0
        imageCustomCell.layer.masksToBounds = true
    }
}
