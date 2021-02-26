//
//  PostsListRequest.swift
//  TestNYT
//
//  Created by Vlad on 26.02.2021.
//

import Foundation

enum allErrors: Error {
    case NoDataAvailable
    case CanNotProcessData
}

struct dataProvider {
    
    let resourceURL = URL(string: "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=zBEln6Etl3VQndwBqiop6C9AckVdDTOG")
    
    init() {}
    
    
    func getList(completion: @escaping(Result<[Post], allErrors>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL!){ (data, _, _) in
            guard let jsonData = data else {
                completion(.failure(.NoDataAvailable))
                return
            }
            do{
                let Ans = try JSONDecoder().decode(Info.self, from: jsonData).results
                completion(.success(Ans))
            } catch {
                completion(.failure(.CanNotProcessData))
            }
        }
        dataTask.resume()
    }
}
