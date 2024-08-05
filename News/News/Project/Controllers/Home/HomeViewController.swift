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
    
    var pokemonData: [Pokemon] = []
    var pokemonImages: [String] = []
    var heightTableViewCell = 100
    var string: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllPokemonImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func fetchAllPokemonImages() {
        
        APIService.shared.fetchPokemonList(offset: 0, limit: 20) { result in
            switch result {
            case .success(let pokemonResponse):
                self.pokemonData = pokemonResponse.results
            case .failure(let error):
                print("Error fetching Pokémon list: \(error)")
            }
        }
        
        self.heightTableView.constant = CGFloat(self.heightTableViewCell * self.pokemonData.count)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupScrollView() {
        self.scrollView.delegate = self
    }
    
    func setupCollectionView() {
        self.bannerCollectionView.delegate = self
        self.bannerCollectionView.dataSource = self
        
        // Make sure the nib file name matches the one in your project
        self.bannerCollectionView.register(UINib(nibName: "PokemonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PokemonCollectionViewCell")
        
        // Layout configuration
        let screenWidth = UIScreen.main.bounds.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth - 32, height: 100)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        self.bannerCollectionView.collectionViewLayout = layout
    }

    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
    }

}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.pokemonData.count {
        case 0:
            return UICollectionViewCell()
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as? PokemonCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let data: Pokemon = self.pokemonData[indexPath.row]
            cell.setupData(name: data.name)
            return cell
        }
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.pokemonData.count {
        case 0:
            return UITableViewCell()
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as? PokemonTableViewCell else { return  UITableViewCell()
            }
            
            let data: Pokemon = self.pokemonData[indexPath.row]
            let image: String = self.pokemonImages[indexPath.row]
            cell.setupData(name: data.name)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


extension HomeViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.heightVHeader.constant =  100 - scrollView.contentOffset.y
    }
}
