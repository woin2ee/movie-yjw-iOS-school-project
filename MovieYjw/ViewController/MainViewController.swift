//
//  MainViewController.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/05/25.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var movieTable: UITableView!
    let movieDataManager = MovieDataManager()
    var dailyBoxOfficeList: [DailyBoxOfficeList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTable.dataSource = self
        movieTable.delegate = self
        setupDailyBoxOfficeList()
    }
    
    func setupDailyBoxOfficeList() {
        movieDataManager.fetchMovieList { result in
            switch result {
            case .success(let list):
                self.dailyBoxOfficeList = list
                DispatchQueue.main.async {
                    self.movieTable.reloadData()
                }
            case .failure(let error):
                return debugPrint(error.localizedDescription)
            }
        }
    }
}

// MARK: - TableView Datasource & Delegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyBoxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        
        cell.name.text = dailyBoxOfficeList[indexPath.row].movieNm
        
        let audiCnt = dailyBoxOfficeList[indexPath.row].audiCnt
        cell.audience.text = "관객 수 : \(NumberFormatter().addComma(to: audiCnt))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
