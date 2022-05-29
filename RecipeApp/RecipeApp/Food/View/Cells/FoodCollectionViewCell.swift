//
//  FoodCollectionViewCell.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 11/04/22.
//

import UIKit
import SDWebImage

final class FoodCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(food: Food) {
        label.text = food.name
        image.sd_setImage(with: URL(string: food.thumb))
    }
}
