//
//  PokemonAPI.swift
//  News
//
//  Created by Phạm Thanh Hải on 5/8/24.
//

import Foundation


class APIService {
    static let shared = APIService()

    func fetchPokemonList(offset: Int, limit: Int, completion: @escaping (Result<PokemonResponse, Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=\(limit)") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(error))
                return
            }

            do {
                let pokemonResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
                completion(.success(pokemonResponse))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }

        task.resume()
    }
    
    func getPokemonImage(name: String, completion: @escaping (Result<DetailPokemonResponse, Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(error))
                return
            }

            do {
                let pokemonResponse = try JSONDecoder().decode(DetailPokemonResponse.self, from: data)
                // Access the desired sprite URL
                completion(.success(pokemonResponse))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }

        task.resume()
    }

}
