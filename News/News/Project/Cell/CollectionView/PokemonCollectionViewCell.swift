//
//  PokemonCollectionViewCell.swift
//  News
//
//  Created by Phạm Thanh Hải on 5/8/24.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var card: PokemonCard!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(image: String = "", name: String) {
        self.card.imgCard.loadImage(from: image, into: self.card.imgCard)
        self.card.lbCard.text = name
    }

}
