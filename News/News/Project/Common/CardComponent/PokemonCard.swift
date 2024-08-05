//
//  PokemonCard.swift
//  News
//
//  Created by Phạm Thanh Hải on 5/8/24.
//

import UIKit

class PokemonCard: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imgCard: UIImageView!
    @IBOutlet weak var lbCard: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        Bundle.main.loadNibNamed("PokemonCard", owner: self)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}


