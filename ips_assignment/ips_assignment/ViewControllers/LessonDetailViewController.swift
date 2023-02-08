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

class LessonDetailViewController: UIViewController, URLSessionDownloadDelegate{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = docsUrl.appendingPathComponent("lessonVideo\(index).mp4")
        
        do{
            try FileManager().moveItem(at: location, to: destinationUrl)
            print("finish download")
            DispatchQueue.main.async { [self] in
                downloadAlertView!.dismiss(animated: true)
                
                let alert = UIAlertController(title: "Alert", message: "Download Completed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } catch{
            fatalError("Couldn't load \(destinationUrl.absoluteString) from main bundle:\n\(error)")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentDownloaded = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        print("percentage is \(percentDownloaded)")
        DispatchQueue.main.async { [self] in
            print("\(Int(percentDownloaded * 100))%")
            downloadProgressView.progress = Float(percentDownloaded)
        }
    }
    
    var index: Int = 0
    var lessons: [Lesson]?
    
    var lesson: Lesson?
    
    private let thumbnailView: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let nextLessonButton = UIButton()
    private let rightTopButton : UIButton = UIButton(type: .custom)
    
    private let buttonColor = UIColor(red: 41/255, green: 114/255, blue: 217/255, alpha: 1.0)
    private var downloadVideoSesson: URLSession?
    private var downloadTask: URLSessionDownloadTask?
    
    private let downloadProgressView = UIProgressView()
    private var downloadAlertView: UIAlertController?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rightTopButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        rightTopButton.tintColor = buttonColor
        rightTopButton.setTitle("  Download", for: .normal)
        rightTopButton.setTitleColor(buttonColor, for: .normal)
        rightTopButton.addTarget(self, action: #selector(self.downloadVideo(_:)), for: .touchUpInside)
        rightTopButton.frame.size = CGSize(width: 80, height: 30)
        
        let rightBarButtonItem = UIBarButtonItem(customView: rightTopButton)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func downloadVideo(_ sender: Any?) {

        let destinationUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("lessonVideo\(index).mp4")
        
        if(FileManager().fileExists(atPath: destinationUrl.path)){
            print("\n\nfile already exists\n\n")
            print(destinationUrl)
            let alert = UIAlertController(title: "Alert", message: "You already downloaded", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else{
            
            if Reachability.isConnectedToNetwork(){
                let videoUrl = lesson!.video_url

                downloadTask = downloadVideoSesson!.downloadTask(with: URL(string: videoUrl)!)
                downloadTask!.resume()
                downloadAlertView = UIAlertController(title: "Download Video\n", message: nil, preferredStyle: .alert)
                downloadAlertView!.addAction(UIAlertAction(title: "Cancel download", style: .cancel, handler: { [self] action in
                    print("Cancel download")
                    downloadTask!.cancel()
                }))

                present(downloadAlertView!, animated: true, completion: { [self] in
                    //  Add your progressbar after alert is shown (and measured)
                    let margin:CGFloat = 8.0
                    let rect = CGRect(x: margin, y: 60.0, width: downloadAlertView!.view.frame.width - margin * 2.0 , height: 22.0)
                    downloadProgressView.frame = rect
                    downloadProgressView.progress = 0.0
                    downloadProgressView.tintColor = buttonColor
                    downloadAlertView!.view.addSubview(downloadProgressView)
                })
            }else{
                let alert = UIAlertController(title: "Alert", message: "You can't download. Please check your network.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lesson = lessons![index]
        // TODO: the screen should be available scrolling for small screen sizes.
//        setupScrollView()
        downloadVideoSesson = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue())
        initChildViews()
    }
    
    @objc func nextLesson(sender : UIButton) {
        index += 1
        if (index < lessons!.count){
            lesson = lessons![index]
            setLesson()
        }else{
            nextLessonButton.removeFromSuperview()
        }
    }
    
    @objc func playMovie(sender : UIButton) {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            if let url = URL(string: lesson!.video_url){
                let player = AVPlayer(url: url)
                        
                let vc = AVPlayerViewController()
                vc.player = player
                
                self.present(vc, animated: true) { vc.player?.play() }
            }
        }else{
            print("Internet Connection not Available!")
            let destinationUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("lessonVideo\(index).mp4")
            
            if(FileManager().fileExists(atPath: destinationUrl.path)){
                let player = AVPlayer(playerItem: AVPlayerItem(asset: AVAsset(url: destinationUrl)))

                let playerViewController = AVPlayerViewController()
                playerViewController.player = player

                self.present(playerViewController, animated: true, completion: {
                    player.play()
                })
            }else{
                let alert = UIAlertController(title: "Alert", message: "You can't play the video", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
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
            nextLessonButton.setTitleColor(buttonColor, for: .normal)
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
