//
//  DetailPokemonViewModel.swift
//  News
//
//  Created by Phạm Thanh Hải on 7/8/24.
//

import Foundation
import UIKit

class DetailPokemonViewModel : NSObject {
    
    private var listPokemon: [Pokemon] = []
    private var listDetailPokemon: [DetailPokemonResponse] = []
    
    var selectedData: Pokemon?
    var detailSelectedData: DetailPokemonResponse?
    
    override init() {
        super.init()
    }
    
    func handleData(data: DetailPokemonEntity, completion: @escaping ([(String, String)]) -> Void) {
        var result: [(String, String)] = []
        
        if let front_default = data.front_default, let back_default = data.back_default, let front_shiny = data.front_shiny, let back_shiny = data.back_shiny {
            result.append(("Front Default", front_default))
            result.append(("Back Default", back_default))
            result.append(("Front Shiny", front_shiny))
            result.append(("Back Shiny", back_shiny))
        }
        
        completion(result)
    }
}
