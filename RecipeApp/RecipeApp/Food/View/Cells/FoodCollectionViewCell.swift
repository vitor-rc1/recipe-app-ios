//
//  FoodCollectionViewCell.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 11/04/22.
//

import UIKit

final class FoodCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
