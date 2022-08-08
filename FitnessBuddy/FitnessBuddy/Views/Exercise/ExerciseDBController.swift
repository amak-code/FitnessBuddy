//
//  ExerciseDBController.swift
//  FitnessBuddy
//
//  Created by Lily Tran on 8/3/22.
//

import Foundation

class ExerciseDBController {
    static let baseURL = URL(string: "https://exercisedb.p.rapidapi.com")
    static let searchbodyPartComponent = "/exercises"
    
    static func fetchExercises( completion: @escaping (Result<[Exercise], NetworkError>) -> Void ) {
        let headers = [
            "X-RapidAPI-Key": "9bc6f26e9bmshe037eb0362bc7e3p15a733jsnaba8730c63df",
                "X-RapidAPI-Host": "exercisedb.p.rapidapi.com",
            "Content-Type": "application/json"
        ]
        
        guard let baseURL = baseURL else {
            return completion(.failure(.invalidURL))
        }
        
        let url = baseURL.appendingPathComponent(searchbodyPartComponent)
        // url = url.appendingPathComponent(part.rawValue)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            do {
                // In case you want to see the JSON. cannot just use this because JSONSerialization returns an AnyObject array.
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                //print(json)
                let exercises = try JSONDecoder().decode([Exercise].self, from: data)
                return completion(.success(exercises))
                
                
            } catch {
                print("Error in the do catch")
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}

