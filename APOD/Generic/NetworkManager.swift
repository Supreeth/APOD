//
//  NetworkManager.swift
//  APOD
//
//  Created by Supreeth Doddabela on 08/09/2022.
//

import Foundation

enum HttpMethod: String {
    case get
    case post
    
    var method: String { rawValue.uppercased() }
}

enum Errors: Error {
    
    case invalidResponse
    case invalidStatusCode(Int)
}

class NetworkManager{
    
    func request<T: Decodable>(fromURL url: URL,
                               httpMethod: HttpMethod = .get,
                               completion: @escaping (Result<T, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.method
        
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                return completion(.failure(Errors.invalidResponse))
            }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completion(.failure(Errors.invalidStatusCode(urlResponse.statusCode)))
            }
            
            guard let data = data else { return }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error)")
                completion(.failure(error))
            }
        }
        
        urlSession.resume()
    }
}
