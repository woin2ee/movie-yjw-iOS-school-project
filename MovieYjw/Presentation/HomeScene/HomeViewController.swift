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
    var dailyBoxOfficeList: [DailyBoxOfficeInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTable.dataSource = self
        movieTable.delegate = self
        setupDailyBoxOfficeList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let vc = segue.destination as? SearchMovieViewController,
            let index = movieTable.indexPathForSelectedRow?.row
        else { return }
        
        vc.movieName = dailyBoxOfficeList[index].movieName
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
        
        let movieName = dailyBoxOfficeList[indexPath.row].movieName
        cell.name.text = movieName
        
        let audiCnt = dailyBoxOfficeList[indexPath.row].audienceCnt
        cell.audienceCnt.text = "어제 관객 수 : \(NumberFormatter().addComma(to: audiCnt))"
        
        let audiAcc = dailyBoxOfficeList[indexPath.row].audienceAcc
        cell.audienceAcc.text = "누적 관객 수 : \(NumberFormatter().addComma(to: audiAcc))"
        
        let openDate = dailyBoxOfficeList[indexPath.row].openDate
        cell.openDate.text = "개봉일 : \(openDate)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Date().toStringPrevDay(by: "yyyy년 MM월 dd일") ?? ""
        return "박스오피스 (\(date) 자 기준)"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
}
