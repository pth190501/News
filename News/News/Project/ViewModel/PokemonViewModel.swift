//
//  PokemonViewModel.swift
//  News
//
//  Created by Phạm Thanh Hải on 5/8/24.
//

import Foundation
import UIKit

class PokemonViewModel: NSObject {
    private var apiService: APIService!
    
    // Closure to notify view when data changes
    var callbackWithListPokemon: (([Pokemon], [DetailPokemonResponse]) -> Void)?
    
    private var listPokemon: [Pokemon] = []
    private var listDetailPokemon: [DetailPokemonResponse] = []
    
    var selectedData: Pokemon?
    var detailSelectedData: DetailPokemonResponse?
    
    override init() {
        super.init()
        self.apiService = APIService()
        callAPIGetListPokemon()
    }
    
    func callAPIGetListPokemon() {
        apiService.fetchPokemonList(offset: 0, limit: 50) { [weak self] result in
            switch result {
            case .success(let pokemonResponse):
                guard let self = self else { return }
                self.listPokemon = pokemonResponse.results
                
                var dataFetch: [DetailPokemonResponse] = []
                
                let dispatchGroup = DispatchGroup()
                
                for pokemon in self.listPokemon {
                    dispatchGroup.enter()
                    self.getPokemonImage(name: pokemon.name) { response in
                        dataFetch.append(response)
                        dispatchGroup.leave() // Move this inside the completion handler
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    self.listDetailPokemon = dataFetch
                    self.callbackWithListPokemon?(self.listPokemon, self.listDetailPokemon)
                }
                
            case .failure(let error):
                print("Error fetching Pokémon list: \(error)")
            }
        }
    }

    
    func getPokemonImage(name: String, completion: @escaping (DetailPokemonResponse) -> Void) {
        apiService.getPokemonImage(name: name) { result in
            switch result {
            case .success(let entity):
                completion(entity)
            case .failure(let error):
                print("Error fetching Pokémon image: \(error)")
            }
        }
    }
    
    func navigateToDetailPokemon(viewController: UIViewController) {
        let vc = DetailPokemonViewController()
        vc.selectedData = self.selectedData
        vc.detailDataSelected = self.detailSelectedData
        
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
