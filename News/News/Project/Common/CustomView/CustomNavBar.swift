//
//  CustomNavBar.swift
//  News
//
//  Created by Phạm Thanh Hải on 6/8/24.
//

import UIKit
import Foundation

enum TypeNavBar {
    case full
    case left_btn_only
    case title_only
    case left_btn_and_title
    case left_right_btn
}

class CustomNavBar: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var vLeftBtn: UIView!
    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vRightBtn: UIView!
    @IBOutlet weak var imgRight: UIImageView!
    
    var type: TypeNavBar = .full {
        didSet {
            self.setupTypeView(type: type)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        Bundle.main.loadNibNamed("CustomNavBar", owner: self, options: nil)
        guard let view = contentView else { return }
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupTypeView(type: TypeNavBar) {
        switch type {
        case .full:
            self.lbTitle.isHidden = false
            self.vLeftBtn.isHidden = false
            self.vRightBtn.isHidden = false
        case .left_btn_only:
            self.lbTitle.isHidden = true
            self.vLeftBtn.isHidden = false
            self.vRightBtn.isHidden = true
        case .title_only:
            self.lbTitle.isHidden = false
            self.vLeftBtn.isHidden = true
            self.vRightBtn.isHidden = true
        case .left_btn_and_title:
            self.lbTitle.isHidden = false
            self.vLeftBtn.isHidden = false
            self.vRightBtn.isHidden = true
        case .left_right_btn:
            self.lbTitle.isHidden = true
            self.vLeftBtn.isHidden = false
            self.vRightBtn.isHidden = false
        }
    }
    
    func configUI(imgLeft: String = "", title: String = "", imgRight: String = "") {
        self.imgLeft.image = UIImage(named: imgLeft)
        self.imgRight.image = UIImage(named: imgRight)
        self.lbTitle.text = title
    }
    
    func configTitle(font: UIFont = .boldSystemFont(ofSize: 18), color: UIColor = .black, alignment: NSTextAlignment = .center) {
        self.lbTitle.font = font
        self.lbTitle.textColor = color
        self.lbTitle.numberOfLines = 0
        self.lbTitle.textAlignment = alignment
        
    }
    
    var setLeftBtnAction: (() -> Void)?
    var setRightBtnAction: (() -> Void)?
    
    @IBAction func tapLeftBtn(_ sender: Any) {
        if let setLeftBtnAction = self.setLeftBtnAction {
            setLeftBtnAction()
        }
    }
    
    @IBAction func tapRightBtn(_ sender: Any) {
        if let setRightBtnAction = self.setRightBtnAction {
            setRightBtnAction()
        }
    }
}
