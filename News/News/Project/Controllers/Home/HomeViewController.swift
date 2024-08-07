//
//  HomeViewController.swift
//  News
//
//  Created by Phạm Thanh Hải on 5/8/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var vHeader: UIView!
    @IBOutlet weak var heightVHeader: NSLayoutConstraint!
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    
    private var viewModel: PokemonViewModel!
    private var listPokemon: [Pokemon] = []
    private var listImg: [DetailPokemonResponse] = []
    
    var heightTableViewCell: CGFloat = 250
    var string: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getListPokemon()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func getListPokemon() {
        if self.viewModel == nil {
            self.viewModel = PokemonViewModel()
            
            self.viewModel.callbackWithListPokemon = { dataPokemon, detailPokemon in
                self.listPokemon = dataPokemon
                self.listImg = detailPokemon
                
                DispatchQueue.main.async {
                    self.heightTableView.constant = self.heightTableViewCell * CGFloat(self.listPokemon.count)
                    
                    self.pageController.numberOfPages = self.listPokemon.count
                    
                    self.tableView.reloadData()
                    self.bannerCollectionView.reloadData()
                }
            }
        }
    }

    
    func setupUI() {
        setupTableView()
        setupCollectionView()
        setupScrollView()
        
        pageController.currentPage = 0
        pageController.currentPageIndicatorTintColor = .blue
        pageController.pageIndicatorTintColor = .lightGray
    }
    
    func setupScrollView() {
        self.scrollView.delegate = self
        self.scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    func setupCollectionView() {
        self.bannerCollectionView.delegate = self
        self.bannerCollectionView.dataSource = self
        self.bannerCollectionView.showsVerticalScrollIndicator = false
        self.bannerCollectionView.showsHorizontalScrollIndicator = false
        
        self.bannerCollectionView.register(UINib(nibName: "PokemonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PokemonCollectionViewCell")
        
        // Layout configuration
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: App.Key().screenWidth - 32, height: 200)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        self.bannerCollectionView.isPagingEnabled = true
        self.bannerCollectionView.collectionViewLayout = layout
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
        self.tableView.separatorColor = .none
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.isScrollEnabled = false
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as? PokemonCollectionViewCell else {
            return  UICollectionViewCell()
        }
        
        let data: Pokemon = self.listPokemon[indexPath.row]
        let image: String = self.listImg[indexPath.row].sprites?.front_default ?? ""
        cell.setupData(image: image, name: data.name)
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 12
        return cell
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as? PokemonTableViewCell else { return  UITableViewCell() }
    
        let data: Pokemon = self.listPokemon[indexPath.row]
        let image: String = self.listImg[indexPath.row].sprites?.front_default ?? ""
        cell.setupData(image: image, name: data.name)
        cell.card.lbCard.textAlignment = .center
        cell.card.imgCard.backgroundColor = .lightGray
        cell.card.lbCard.layer.borderColor = UIColor.blue.cgColor
        cell.card.lbCard.layer.borderWidth = 1
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data: Pokemon = self.listPokemon[indexPath.row]
        let detailData: DetailPokemonResponse = self.listImg[indexPath.row]
        self.viewModel.selectedData = data
        self.viewModel.detailSelectedData = detailData
        self.viewModel.navigateToDetailPokemon(viewController: self)
    }
}


extension HomeViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.heightVHeader.constant =  100 - scrollView.contentOffset.y
        
        if (scrollView == bannerCollectionView) {
            pageController.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }
    }
}
