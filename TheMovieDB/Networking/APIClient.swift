//
//  APIClient.swift
//  TheMovieDB
//
//  Created by Eduardo Geovanni Pérez Munguía on 21/05/24.
//

import Foundation
class APIClient {
    
    func getDataUpcoming(completion: @escaping (Result<MovieModel,Error>) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "c2bcfa61f1mshf2abcf111b8af04p11138ejsnd5ae171d439b",
            "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"
        ]
        
        var request = URLRequest(url:URL(string: "https://moviesdatabase.p.rapidapi.com/titles/x/upcoming")!, timeoutInterval: Double.infinity)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            //print(String(data: data, encoding: .utf8)!)
            do {
                let result = try JSONDecoder().decode(MovieModel.self, from: data)
                completion(.success(result))
            } catch {
                print("Error decoding JSON:\(error)")
                completion(.failure(error))
            }
            
        }.resume()
        
    }
    
    func getDataComedy(completion: @escaping (Result<MovieModel,Error>) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "c2bcfa61f1mshf2abcf111b8af04p11138ejsnd5ae171d439b",
            "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"
        ]
        
        var request = URLRequest(url:URL(string: "https://moviesdatabase.p.rapidapi.com/titles?genre=Comedy")!, timeoutInterval: Double.infinity)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
          
            do {
                let result = try JSONDecoder().decode(MovieModel.self, from: data)
                completion(.success(result))
            } catch {
                print("Error decoding JSON:\(error)")
                completion(.failure(error))
            }
            
        }.resume()
        
    }
    
}

