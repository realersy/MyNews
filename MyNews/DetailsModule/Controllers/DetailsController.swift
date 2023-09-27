//
//  DetailsController.swift
//  MyNews
//
//  Created by Ersan Shimshek on 27.09.2023.
//

import Foundation
import UIKit

final class DetailsController: UIViewController {
    
    //MARK: Properties
    let imageView = UIImageView()
    let authorLabel = UILabel()
    let descLabel = UILabel()
    let urlLabel = UILabel()
    let urlStringLabel = UILabel()
    
    private var liked: Bool = false {
        didSet {
            if liked {
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(bookmarked))
            } else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(bookmarked))
            }
        }
    }
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    var article: Article?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(bookmarked))
        liked = ProfileService.shared.getModel().contains { $0 == article }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setup()
    }
    
    //MARK: Custom Init
    init(article: Article) {
        super.init(nibName: nil, bundle: nil)
        self.article = article
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension DetailsController {
    
    //Setup UI Elements
    private func setup(){
        
        //Image View
        startSpinner()
        NewsService.shared.getImage(url: (article?.urlToImage)!) { [weak self] data in
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
                self!.stopSpinner()
            }
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 18
        imageView.backgroundColor = .gray
        imageView.addSubview(activityIndicator)
        view.addSubview(imageView)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: (navigationController?.navigationBar.frame.height)! + 5),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        //Author Label
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authorLabel)
        authorLabel.text = article?.author
        authorLabel.textColor = .black
        authorLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        NSLayoutConstraint.activate([
            authorLabel.heightAnchor.constraint(equalToConstant: 20),
            authorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 18),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
            
        ])
        
        //Description
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descLabel)
        descLabel.text = article?.description
        descLabel.font = UIFont(name: "Baskerville", size: 15)
        descLabel.numberOfLines = 0
        descLabel.textColor = .black
        NSLayoutConstraint.activate([
            descLabel.heightAnchor.constraint(equalToConstant: 120),
            descLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 15),
            descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
            
        ])
        
        //URL Label
        urlLabel.translatesAutoresizingMaskIntoConstraints = false
        urlLabel.text = "For more information visit:"
        urlLabel.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 15)
        urlLabel.numberOfLines = 0
        urlLabel.textColor = .black
        view.addSubview(urlLabel)
        
        NSLayoutConstraint.activate([
            urlLabel.heightAnchor.constraint(equalToConstant: 30),
            urlLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 15),
            urlLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            urlLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
            
        ])
        
        urlStringLabel.translatesAutoresizingMaskIntoConstraints = false
        urlStringLabel.text = article?.url
        urlStringLabel.textColor = .blue
        urlStringLabel.backgroundColor = .white
        urlStringLabel.numberOfLines = 0
        view.addSubview(urlStringLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelDidGetTapped))
        urlStringLabel.isUserInteractionEnabled = true
        urlStringLabel.addGestureRecognizer(tapGesture)
        NSLayoutConstraint.activate([
            urlStringLabel.heightAnchor.constraint(equalToConstant: 50),
            urlStringLabel.topAnchor.constraint(equalTo: urlLabel.bottomAnchor),
            urlStringLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            urlStringLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
            
        ])
    }
}
//MARK: Target Functions
extension DetailsController {
    @objc
    func labelDidGetTapped(sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else {
            return
        }
        UIPasteboard.general.string = label.text
        
        let alertController = UIAlertController(title: "Link Copied", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @objc
    func bookmarked(){
        if !FileService.shared.readModel().favNews.contains(where: { art in self.article == art }) {
            ProfileService.shared.addItem(item: article!)
            liked = true
        }
        else {
            ProfileService.shared.removeItem(elem: article!)
            liked = false
        }
    }
}

//MARK: Spinner Methods
extension DetailsController {
    //MARK: Spinner Methods
    private func startSpinner(){
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    private func stopSpinner(){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
