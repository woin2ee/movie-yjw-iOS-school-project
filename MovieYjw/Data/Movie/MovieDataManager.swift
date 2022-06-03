//
//  MovieDataManager.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/06/03.
//

import Foundation

enum APIRequestError: Error {
    case invalidURL
    case failureStatusCode
    case missingData
    case decodeError
    case anyError(_: Error)
}

struct MovieDataManager {
    let successRange = 200..<300
    let yesterday: String
    var url: URL?
    
    init() {
        self.yesterday = Date().toStringPrevDay(by: "yyyyMMdd") ?? ""
        self.url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(Personal.API_KEY.rawValue)&targetDt=\(yesterday)")
    }
    
    // MARK: - Movie Data API
    
    func fetchMovieList(completion: @escaping (Result<[DailyBoxOfficeList], APIRequestError>) -> Void) {
        guard let url = self.url else {
            return completion(.failure(.invalidURL))
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error {
                return completion(.failure(.anyError(error)))
            }
            
            guard let data = data else {
                return completion(.failure(.missingData))
            }
            
            guard
                let response = urlResponse as? HTTPURLResponse,
                    successRange.contains(response.statusCode) else {
                return completion(.failure(.failureStatusCode))
            }
            
            guard let movieData = try? JSONDecoder().decode(MovieData.self, from: data) else {
                return completion(.failure(.decodeError))
            }
            
            completion(.success(movieData.boxOfficeResult.dailyBoxOfficeList))
        }
        
        task.resume()
    }
}
