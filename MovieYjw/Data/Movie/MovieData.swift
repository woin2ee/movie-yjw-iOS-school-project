//
//  MovieData.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/05/25.
//

import Foundation

struct MovieData: Codable {
    let  boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let  dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable {
    let  movieNm: String
    let  audiCnt: String
}
