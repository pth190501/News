//
//  ItemComponent.swift
//  News
//
//  Created by Phạm Thanh Hải on 6/8/24.
//

import UIKit

class ItemDetailComponent: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stvContent: UIStackView!
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var imgExpand: UIImageView!
    @IBOutlet weak var lbSub: UILabel!
    @IBOutlet weak var vSub: UIView!
    
    var data: (String, String)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        Bundle.main.loadNibNamed("ItemDetailComponent", owner: self)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.lbTitle.text = data?.0
        self.lbSub.text = data?.1
    }
    
    var onClick: (() -> Void)?
    
    @IBAction func tapShowFull(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.vSub.alpha = self.vSub.isHidden ? 1.0 : 0.0
        }) { _ in
            self.vSub.isHidden.toggle()
        }
        
        self.imgExpand.image = UIImage(named: "ic_up")
        if (self.vSub.isHidden) {
            self.imgExpand.image = UIImage(named: "ic_down")
        }
        
        if let onClick = self.onClick {
            onClick()
        }
    }

}
