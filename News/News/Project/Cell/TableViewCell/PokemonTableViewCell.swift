//
//  PokemonTableViewCell.swift
//  News
//
//  Created by Phạm Thanh Hải on 5/8/24.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var card: PokemonCard!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(image: String = "", name: String) {
        self.card.lbCard.text = name
        if (!image.isEmpty) {
            self.card.imgCard.loadImage(from: image, into: self.card.imgCard)
        }
    }
    
}
