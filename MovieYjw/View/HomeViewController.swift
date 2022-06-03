//
//  HomeViewController.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/05/25.
//

import UIKit

class HomeViewController: UIViewController {
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyBoxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        
        cell.name.text = dailyBoxOfficeList[indexPath.row].movieNm
        
        let audiCnt = dailyBoxOfficeList[indexPath.row].audiCnt
        cell.audienceCnt.text = "어제 관객 수 : \(NumberFormatter().addComma(to: audiCnt))"
        
        let audiAcc = dailyBoxOfficeList[indexPath.row].audiAcc
        cell.audienceAcc.text = "누적 관객 수 : \(NumberFormatter().addComma(to: audiAcc))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "박스오피스"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
