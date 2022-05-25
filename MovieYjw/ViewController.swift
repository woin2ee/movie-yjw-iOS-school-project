//
//  ViewController.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/05/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var movieTable: UITableView!
    
    var dailyBoxOfficeList: [DailyBoxOfficeList] = []
    var date: String {
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            return formatter
        }()
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return formatter.string(from: Date())
        }
        return formatter.string(from: yesterday)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        movieTable.dataSource = self
        movieTable.delegate = self
        
        fetchMovieList()
    }
    
    func fetchMovieList() {
        let successRange = 200..<300
        guard let url = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(Storage.API_KEY.rawValue)&targetDt=\(date)") else { return }
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                debugPrint("데이터를 가져오지 못했습니다.")
                return
            }
            guard successRange.contains(response.statusCode) else {
                debugPrint("응답 코드 오류.")
                return
            }
            let decoder = JSONDecoder()
            guard let movieData = try? decoder.decode(MovieData.self, from: data) else {
                debugPrint("데이터 Decode 실패")
                return
            }
            dailyBoxOfficeList = movieData.boxOfficeResult.dailyBoxOfficeList
            DispatchQueue.main.async {
                self.movieTable.reloadSections(IndexSet(0...0), with: .automatic)
            }
        }.resume()
    }
    
    func numberFormatter(num: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: num))!
    }
    
    func numberFormatter(num: String) -> String {
        let formatter = NumberFormatter()
        guard let nsNum = formatter.number(from: num) else { return num }
        formatter.numberStyle = .decimal
        return formatter.string(from: nsNum)!
    }
    
}

// MARK: - TableView Datasource & Delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyBoxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        cell.movieName.text = dailyBoxOfficeList[indexPath.row].movieNm
        cell.movieCount.text = "관객 수 : \(numberFormatter(num: dailyBoxOfficeList[indexPath.row].audiCnt))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
