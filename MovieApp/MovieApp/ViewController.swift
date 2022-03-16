//
//  ViewController.swift
//  MovieApp
//
//  Created by Jae kwon Choi on 2022/01/07.
//

import UIKit

class ViewController: UIViewController {

    //미리 지정해둠
    var movieModel: MovieModel?
    var term = ""
    var networkLayer = NetworkLayer()
    
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이벤트 그걸 눌렀을떄 뭘할꺼냐. 등등
        movieTableView.delegate = self
        // 데이터를 연결하는쪽
        movieTableView.dataSource = self
        searchBar.delegate = self
        
        requestMovieAPI()
        
    }
    
    //이미지 받아오기
    //밑에꺼랑 아예 같은 코드임 줄인것.
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void ) {
        networkLayer.request(type: .justURL(urlString: urlString)) { data, response, error in
            if let hasData = data {
                completion(UIImage(data: hasData))
                return
            }
            completion(nil)
        }
    }
    
    
//    //이미지 받아오기
//    // @escaping은 이제 .dataTask안에서만 data값이 있는데 이건 저 .dataTask밖에 나오면 사라지기떄문에 func에서도 사용하려면 클로져앞에
//    // 이렇게 적어줘야 사용이 가능하다.
//    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void ) {
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig)
//
//        if let hasURL = URL(string: urlString) {
//            var request = URLRequest(url: hasURL)
//            request.httpMethod = "GET"
//
//            session.dataTask(with: request) { data, response, error in
//                print( (response as! HTTPURLResponse).statusCode )
//
//                if let hasData = data {
//                    completion(UIImage(data: hasData))
//                    return
//                }
//            }.resume()
//            session.finishTasksAndInvalidate()
//        }
//
//        //실패한 경우를 대비해서 적어둬야함
//        completion(nil)
//
//    }
    
    //네트워크호출
    //밑에꺼랑 아예 같은 코드임 줄인것.
    func requestMovieAPI() {
        
        let term = URLQueryItem(name: "term", value: term)
        let media = URLQueryItem(name: "media", value: "movie")
        let querys = [term, media]
        
        networkLayer.request(type: .searchMovie(querys: querys)) { data, response, error in
            if let hasData = data {
                do{
                    self.movieModel =  try JSONDecoder().decode(MovieModel.self, from: hasData)
                                        
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()
                    }
                    
                } catch {
                    print(error)
                }
            }
        }
    }
    
//    //네트워크호출
//    func requestMovieAPI() {
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig)
//
//        var components = URLComponents(string: "https://itunes.apple.com/search")
//
//        let term = URLQueryItem(name: "term", value: term)
//        let media = URLQueryItem(name: "media", value: "movie")
//
//        components?.queryItems = [term, media]
//        //https://itunes.apple.com/search?term=marvel&media=movie 가 위에 코드랑 같다.
//
//        guard let url = components?.url else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        let task = session.dataTask(with: request) { data, response, error in
//            //제일중요하다
//            print( (response as! HTTPURLResponse).statusCode )
//
//            if let hasData = data {
//                do{
//                    self.movieModel =  try JSONDecoder().decode(MovieModel.self, from: hasData)
//
//                    print(self.movieModel ?? "no data")
//
//                    DispatchQueue.main.async {
//                        self.movieTableView.reloadData()
//                    }
//
//                } catch {
//                    print(error)
//                }
//            }
//        }
//
//        task.resume()//실행
//        session.finishTasksAndInvalidate()//세션을 끝내야한다.
//
//    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //섹션별 행에 해당하는 데이터는 몇개인가?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieModel?.results.count ?? 0
    }
    
    // 그테이블을 눌렀을때 이벤트
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 스토리보드를 가져오고, 그리고 뷰컨트롤러의 identity를 가져오기
        let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        // 눌렀다가 클릭되었다는걸 사라지게함
        tableView.deselectRow(at: indexPath, animated: true)
    
        // 몇번을 눌렀는지 그걸 detailVC에 알려준다
        detailVC.movieResult = self.movieModel?.results[indexPath.row]
        
        //화면을 풀스크린으로 하고싶으면 이렇게 채우면된다.
        //detailVC.modalPresentationStyle = .fullScreen
        
        //화면 보여주기
        self.present(detailVC, animated: true) { }
        
    }
    
    // cell의 높이
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // 콘텐츠 내용만큼 해주겠다.
        return UITableView.automaticDimension
    }

    
    // 셀의모양,그행의 셀은 어떤 데이터를 가졌냐
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 규격이니 외워라 타입캐스팅은 강제로 해야함
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.titleLabel.text = self.movieModel?.results[indexPath.row].trackName
        cell.descriptionLabel.text = self.movieModel?.results[indexPath.row].shortDescription
        
        //통화
        let currency = self.movieModel?.results[indexPath.row].currency ?? ""
        //가격
        let price = self.movieModel?.results[indexPath.row].trackPrice?.description ?? ""
        
        cell.priceLabel.text = currency + price
        
        // 이미지 가져오기
        if let hasURL = self.movieModel?.results[indexPath.row].image {
            self.loadImage(urlString: hasURL) { image in
                DispatchQueue.main.async {
                    cell.movieImageView.image = image
                }
            }
        }
        
        
        if let dateString = self.movieModel?.results[indexPath.row].releaseDate {
            // json 규격
            let formatter = ISO8601DateFormatter()
            // 데이터를 받아온것
            if let isoDate = formatter.date(from: dateString) {
                // 내가원하는 스타일 적기
                let myFormatter = DateFormatter()
                myFormatter.dateFormat = "yyyy년 MM월 dd일"
                let dateString = myFormatter.string(from: isoDate)
                
                cell.dateLabel.text = dateString
            }
        }
              
        return cell
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    // 버튼을 눌렀을때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let hasText = searchBar.text else {
            return
        }
        term = hasText
        requestMovieAPI()
        //검색후 키도브내리기
        self.view.endEditing(true)
    }
}

