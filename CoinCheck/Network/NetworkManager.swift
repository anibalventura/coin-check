//
//  NetworkManager.swift
//  CoinCheck
//
//  Created by Anibal Ventura on 4/1/22.
//

import Foundation

struct NetworkManager {

    // Fetch data from a string URL and parse it to a generic T model.
    func fetchData<T: Codable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { completion(.failure(error)); return }

            completion(Result {
                try JSONDecoder().decode(T.self, from: data!)
            })
        }.resume()
    }
}
