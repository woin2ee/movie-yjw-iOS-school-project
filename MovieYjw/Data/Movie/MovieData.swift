//
//  MovieData.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/05/25.
//

import Foundation

struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeInfo]
}

struct DailyBoxOfficeInfo: Codable {
    let movieName: String
    let audienceCnt: String
    let audienceAcc: String
    let openDate: String
    
    enum CodingKeys: String, CodingKey {
        case movieName = "movieNm"
        case audienceCnt = "audiCnt"
        case audienceAcc = "audiAcc"
        case openDate = "openDt"
    }
}
