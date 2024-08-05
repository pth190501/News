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

struct PokemonSpritesResponse: Codable {
    let id: Int
    let sprites: PokemonSpritesEntity
}

struct PokemonSpritesEntity: Codable {
    let front_default: String?
}



