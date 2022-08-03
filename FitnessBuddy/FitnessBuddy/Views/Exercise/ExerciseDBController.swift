//
//  ExerciseDBController.swift
//  FitnessBuddy
//
//  Created by Lily Tran on 8/3/22.
//

import Foundation

class ExerciseDBController {
    static let baseURL = URL(string: "https://exercisedb.p.rapidapi.com")
    static let searchbodyPartComponent = "/exercises/bodyPart"
    
    static func fetchExercises(by part: bodyParts, completion: @escaping (Result<[Exercise], NetworkError>) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "6b1fb347bfmshfc36be9e526e3b9p1c7b99jsn7a1de3800113",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
        ]
        
        
        guard let baseURL = baseURL else {
            return
        }
        
        var url = baseURL.appendingPathComponent(searchbodyPartComponent)
        url = url.appendingPathComponent(part.rawValue)
        
        var request = URLRequest(url: url)
//        print(request)
//        print(url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            if let error = error {
                print("There is an error")
                return
            }
            
            guard let data = data else {
                print("invalid data")
                return }
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                //print(json)
                let exercises = try JSONDecoder().decode([Exercise].self, from: data)
                completion(.success(exercises))
                return
                
            } catch {
                print("Error in the do catch")
                return
            }
        }.resume()
    }
}

