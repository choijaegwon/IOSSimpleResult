//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Jae kwon Choi on 2022/01/08.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {
    
    var movieResult: MovieResult?
    
    var player: AVPlayer?

    @IBOutlet weak var movieContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // 데이터를 받자마자 하면 nil 값이 나오기떄문에 viewDidLoad인 시점에 올려줘야한다.
        titleLabel.text = movieResult?.trackName
        descriptionLabel.text = movieResult?.longDescription
    
    }
    
    //viewDidLoad는 애초에 지정되 있는 크기를 사용하는 것이라 작아지는 것이다.
    // 따라서 올라온 이시점에 해야지 기종이 달라도 뷰자체에 적용할수 있다.
    override func viewDidAppear(_ animated: Bool) {
        if let hasURL = movieResult?.previewUrl {
            makePlayerAndPlay(urlString: hasURL)
        }
    }
    
    
    func makePlayerAndPlay(urlString: String) {
        
        if let hasurl = URL(string: urlString) {
            //주소로써 영상을 플레이한다.
            self.player = AVPlayer(url: hasurl)
            let playerLayer = AVPlayerLayer.init(player: self.player)
            
            // view가 아니기 때문에 layer를 통해서 올려줘야한다.
            // 레이어는 절대값만 있어서 오토레이아웃은 안된다.
            movieContainer.layer.addSublayer(playerLayer)
            
            //화면에 맞춰서 올리기
            playerLayer.frame = movieContainer.bounds
            
            //바로시작하기
            self.player?.play()
            
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func play(_ sender: Any) {
        self.player?.play()
    }
    @IBAction func stop(_ sender: Any) {
        self.player?.pause()
    }

}
