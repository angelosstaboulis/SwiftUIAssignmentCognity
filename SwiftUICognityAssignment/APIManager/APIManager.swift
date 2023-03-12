//
//  APIManager.swift
//  SwiftUICognityAssignment
//
//  Created by Angelos Staboulis on 10/3/23.
//

import Foundation
import SwiftyJSON
class APIManager{
    public static let shared = APIManager()
    func fetchShows() async -> [SHOWModel] {
        let url = URL(string: API_URL)!
        let session = URLSession.shared
        typealias Continuation = CheckedContinuation<[SHOWModel], Never>
        let shows = await withCheckedContinuation { (continuation: Continuation) in
            let task = session.dataTask(with: url) { data, response, error in
                var result: [SHOWModel] = []
                defer {
                    continuation.resume(returning: result)
                }
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let data = data else {
                    return
                }
                do {
                    let json = try JSON(data: data)
                    for value in 0..<json.count{
                        result.append(SHOWModel(name: json[value]["name"].stringValue, rating: String(format:"%.2f",json[value]["rating"]["average"].doubleValue), thumbnail: json[value]["image"]["medium"].stringValue))
                    }
                    
                } catch {
                    print("JSON Error \(error.localizedDescription)")
                    return
                }
            }
            task.resume()
        }
        
        return shows
    }
    
}
