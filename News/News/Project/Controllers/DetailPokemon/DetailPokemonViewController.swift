//
//  DetailPokemonViewController.swift
//  News
//
//  Created by Phạm Thanh Hải on 6/8/24.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    
    var selectedData: Pokemon?
    var detailDataSelected: DetailPokemonResponse?
    
    @IBOutlet weak var navBar: CustomNavBar!
    
    @IBOutlet weak var vPrevious: UIView!
    @IBOutlet weak var imgPrevious: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var vNext: UIView!
    @IBOutlet weak var imgNext: UIImageView!
    
    @IBOutlet weak var stvContent: UIStackView!
    
    var viewModel: DetailPokemonViewModel?
    
    var currentPos: Int = 0
    var number: Int = 0
    var arrData: [(String, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getListImage()
        setupNavBar()
        setupCollectionView()
        setupUI()
    }
    
    func setupNavBar() {
        if let name = selectedData?.name {
            self.navBar.configUI(imgLeft: "ic_back", title: name)
        }
        self.navBar.configTitle()
        
        self.navBar.setLeftBtnAction = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView.register(UINib(nibName: "PokemonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PokemonCollectionViewCell")
        
        // Layout configuration
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: App.Key().screenWidth - 50*2, height: 250)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        self.collectionView.isScrollEnabled = false
        self.collectionView.collectionViewLayout = layout
    }
    
    func setupUI() {
        self.imgPrevious.isHidden = true
        self.imgPrevious.image = UIImage(named: "ic_back")
        self.imgPrevious.isUserInteractionEnabled = true
        self.imgPrevious.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapPreviousBtn)))
        
        self.imgNext.image = UIImage(named: "ic_next")
        self.imgNext.isUserInteractionEnabled = true
        self.imgNext.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapNextBtn)))
        
        if let id = detailDataSelected?.id, let name = detailDataSelected?.name, let weight = detailDataSelected?.weight, let base_experience = detailDataSelected?.base_experience, let order = detailDataSelected?.order {
            let item: [(String, String)] = [("id", String(id)), ("name", name), ("weight", String(weight)), ("base experience", String(base_experience)), ("order", String(order))]
            
            addLabelsToView(items: item)
            
        }
        
    }
    
    func addLabelsToView(items: [(String, String)]) {
        for item in items {
            let view = ItemDetailComponent()
            
            self.stvContent.addArrangedSubview(view)
            
            view.lbTitle.text = item.0
            view.lbSub.text = item.1
            view.stvContent.layer.borderColor = UIColor.black.cgColor
            view.stvContent.layer.borderWidth = 1
            
            view.onClick = {
                self.view.layoutIfNeeded()
                self.view.layoutSubviews()
            }
        }
    }
    
    private func getListImage() {
        if self.viewModel == nil {
            self.viewModel = DetailPokemonViewModel()
            
            if let sprites = detailDataSelected?.sprites {
                self.viewModel?.handleData(data: sprites, completion: { result in
                    self.arrData = result
                    self.number = self.arrData.count
                })
            }
            
        }
    }
    
    @objc func tapPreviousBtn() {
        if (self.currentPos > 0) {
            self.currentPos -= 1
            self.imgPrevious.isHidden = (self.currentPos == 0)
            self.imgNext.isHidden = (self.currentPos == self.number - 1)
            self.collectionView.scrollToItem(at: IndexPath(row: self.currentPos, section: 0), at: .left, animated: true)
            print(self.currentPos)
        }
    }
    
    @objc func tapNextBtn() {
        if (self.currentPos < (self.number - 1)) {
            self.currentPos += 1
            self.imgPrevious.isHidden = (self.currentPos == 0)
            self.imgNext.isHidden = (self.currentPos == self.number - 1)
            self.collectionView.scrollToItem(at: IndexPath(row: self.currentPos, section: 0), at: .left, animated: true)
            print(self.currentPos)
        }
    }
}

extension DetailPokemonViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as? PokemonCollectionViewCell else {
            return  UICollectionViewCell()
        }
        
        let image = self.arrData[indexPath.row].1
        let name = self.arrData[indexPath.row].0
        
        cell.setupData(image: image, name: name)
        cell.card.lbCard.textAlignment = .center
        cell.card.layer.borderColor = UIColor.lightGray.cgColor
        cell.card.layer.borderWidth = 1
        cell.card.layer.cornerRadius = 12
        return cell
    }
}
