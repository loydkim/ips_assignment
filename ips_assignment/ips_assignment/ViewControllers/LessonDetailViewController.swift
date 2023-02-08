//
//  LessonDetail.swift
//  ips_assignment
//
//  Created by Loyd Kim on 2023-02-04.
//

import UIKit
import SwiftUI
import AVKit
import AVFoundation

struct LessonDetailViewControllerWrapper: UIViewControllerRepresentable{
    var index: Int
    var lessons: [Lesson]
    typealias UIViewControllerType = LessonDetailViewController
    func makeUIViewController(context: Context) -> LessonDetailViewController {
        let lessonDetailViewController = LessonDetailViewController()
        lessonDetailViewController.index = index
        lessonDetailViewController.lessons = lessons
        return lessonDetailViewController
    }
    
    func updateUIViewController(_ uiViewController: LessonDetailViewController, context: Context) { }
}

class LessonDetailViewController: UIViewController{
    var index: Int = 0
    var lessons: [Lesson]?
    
    var lesson: Lesson?
    
    private let thumbnailView: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let nextLessonButton = UIButton()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.downloadVideo(_:)))
    }
    
    @objc func downloadVideo(_ sender: Any?) {
        print("downloadVideo")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lesson = lessons![index]
        // TODO: the screen should be available scrolling for small screen sizes.
//        setupScrollView()
        initChildViews()
    }
    
    @objc func nextLesson(sender : UIButton) {
        print("Move to next Lesson")
        index += 1
        if (index < lessons!.count){
            lesson = lessons![index]
            setLesson()
        }else{
            nextLessonButton.removeFromSuperview()
        }
    }
    
    @objc func playMovie(sender : UIButton) {
        if let url = URL(string: lesson!.video_url)
        {
            let player = AVPlayer(url: url)
                    
            let vc = AVPlayerViewController()
            vc.player = player
            
            self.present(vc, animated: true) { vc.player?.play() }
        }
    }
    
    private func setLesson() {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: self!.lesson!.thumbnail)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self!.thumbnailView.image = image
                    }
                }
            }
        }
        nameLabel.text = lesson!.name
        descriptionLabel.text = lesson!.description
        if(index == lessons!.count - 1){
            nextLessonButton.removeFromSuperview()
        }
    }
    
    private func initChildViews() {
        thumbnailView.backgroundColor = .systemGray2
        self.view.addSubview(thumbnailView)
        
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        thumbnailView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        thumbnailView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        thumbnailView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        let playButton = UIButton()
//        playButton.frame = CGRect(x: 0, y: 0, width: 350, height: 350)
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.tintColor = UIColor.white
//        playButton.setTitle("Next Lesson >", for: .normal)
//        playButton.setTitleColor(UIColor(red: 41/255, green: 101/255, blue: 250/255, alpha: 1.0), for: .normal)
        playButton.addTarget(self, action: #selector(self.playMovie), for: .touchUpInside)
        self.view.addSubview(playButton)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.centerXAnchor.constraint(equalTo: thumbnailView.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: thumbnailView.centerYAnchor).isActive = true
        
        // TODO: Need to increase play button. It doesn't work.
        playButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 26)
        
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 0
        self.view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14).isActive = true
        nameLabel.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 20).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        self.view.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        setLesson()
        
        if(index < lessons!.count - 1){
            nextLessonButton.setTitle("Next Lesson >", for: .normal)
            nextLessonButton.setTitleColor(UIColor(red: 41/255, green: 101/255, blue: 250/255, alpha: 1.0), for: .normal)
            nextLessonButton.addTarget(self, action: #selector(self.nextLesson), for: .touchUpInside)
            self.view.addSubview(nextLessonButton)
            
            nextLessonButton.translatesAutoresizingMaskIntoConstraints = false
            nextLessonButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10).isActive = true
            nextLessonButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
            nextLessonButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
            nextLessonButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }else{
            nextLessonButton.removeFromSuperview()
        }
    }
}
