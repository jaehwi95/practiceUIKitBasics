//
//  GCDNetworkService.swift
//  testTechStacks
//
//  Created by Jaehwi Kim on 2023/12/28.
//

import Foundation

class GCDNetworkService {
    static let shared = GCDNetworkService()
    
    func getStringAfter1Seconds(completionHandler: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completionHandler("1 second passed!")
        }
    }
    
    func getStringAfter3Seconds(completionHandler: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
            completionHandler("3 second passed!")
        }
    }
    
    func getStringAfter5Seconds(completionHandler: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 5.0) {
            completionHandler("5 second passed!")
        }
    }
    
    func getRandomPokemonName(completionHandler: @escaping (String) -> Void) {
        let randomNumber: Int = Int.random(in: 1...500)
        let url: URL = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomNumber)/")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("client error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("server error")
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Pokemon.self, from: data)
                    completionHandler(response.name)
                } catch {
                    print("Parse Error")
                }
            }
        }
        task.resume()
    }
    
    func getPepeImage(completionHandler: @escaping (Data) -> Void) {
        let url: URL = URL(string: "https://ca-times.brightspotcdn.com/dims4/default/0351323/2147483647/strip/false/crop/960x539+0+0/resize/960x539!/quality/75/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Fc9%2F98%2Ffa3b0cb001e3541c5818a89cd5cc%2Fla-1475087498-snap-photo")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("client error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("server error")
                return
            }
            
            if let data = data {
                completionHandler(data)
            }
        }
        task.resume()
    }
}

struct Pokemon: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}
