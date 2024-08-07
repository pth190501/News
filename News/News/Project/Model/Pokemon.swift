//
//  Pokemon.swift
//  News
//
//  Created by Phạm Thanh Hải on 5/8/24.
//

import Foundation

struct PokemonResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct DetailPokemonResponse: Codable {
    let id: Int?
    let name: String?
    let weight: Int?
    let base_experience: Int?
    let order: Int?
    
    let sprites: DetailPokemonEntity?
}

struct DetailPokemonEntity: Codable {
    let front_default: String?
    let back_default: String?
    let front_shiny: String?
    let back_shiny: String?
}



