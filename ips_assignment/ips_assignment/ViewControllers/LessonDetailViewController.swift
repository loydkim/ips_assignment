//
//  LessonDetail.swift
//  ips_assignment
//
//  Created by Loyd Kim on 2023-02-04.
//

import UIKit
import SwiftUI

struct LessonDetailViewControllerWrapper: UIViewControllerRepresentable{
    var lesson: Lesson
    typealias UIViewControllerType = LessonDetailViewController
    func makeUIViewController(context: Context) -> LessonDetailViewController {
        let lessonDetailViewController = LessonDetailViewController()
        lessonDetailViewController.lesson = lesson
        return lessonDetailViewController
    }
    
    func updateUIViewController(_ uiViewController: LessonDetailViewController, context: Context) { }
}

class LessonDetailViewController: UIViewController{
    var lesson: Lesson?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.downloadVideo(_:)))
    }
    
    @objc func downloadVideo(_ sender: Any?) {
        print("downloadVideo")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChildViews()
    }
    
    @objc func nextLesson(sender : UIButton) {
        print("Move to next Lesson")
    }
    
    func setChildViews() {
        let thumbnailView: UIImageView = UIImageView()
        self.view.addSubview(thumbnailView)
        thumbnailView.backgroundColor = .red
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        thumbnailView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        thumbnailView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        thumbnailView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        let nameLabel: UILabel = UILabel()
        nameLabel.text = lesson?.name ?? "No name"
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 3
        self.view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 10).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        let descriptionLabel: UILabel = UILabel()
        descriptionLabel.text = lesson?.description ?? "No Description"
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 3
        self.view.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        let nextLesson = UIButton()
        nextLesson.setTitle("Next Lesson >", for: .normal)
        nextLesson.setTitleColor(UIColor(red: 41/255, green: 101/255, blue: 250/255, alpha: 1.0), for: .normal)
        nextLesson.addTarget(self, action: #selector(self.nextLesson), for: .touchUpInside)
        self.view.addSubview(nextLesson)
        
        nextLesson.translatesAutoresizingMaskIntoConstraints = false
        nextLesson.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10).isActive = true
        nextLesson.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        nextLesson.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nextLesson.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
}
