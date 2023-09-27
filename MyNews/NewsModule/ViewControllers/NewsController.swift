//
//  ViewController.swift
//  MyNews
//
//  Created by Ersan Shimshek on 27.09.2023.
//

import UIKit

class NewsController: UIViewController {
    
    //MARK: Properties
    let newsTableView = UITableView()
    var articles: [Article]?
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        startSpinner()
        NewsService.shared.getNews { [weak self] art in
            self?.articles = art
            DispatchQueue.main.async {
                self?.stopSpinner()
                self?.newsTableView.reloadData()
            }
        }
    }
}

//MARK: Setup
extension NewsController {
    private func setup(){
        view.backgroundColor = .white
        view.addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.cellID)
        newsTableView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
}

//MARK: UITableViewDataSource, UITableViewDelegate
extension NewsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: NewsCell.cellID, for: indexPath) as! NewsCell
        
        cell.config(author: articles![indexPath.row].author ?? "Author unavailable :(",
                    desc: articles![indexPath.row].description ?? "Not found :(",
                    date: articles![indexPath.row].publishedAt?.trim() ?? "No date :(")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsController(article: articles![indexPath.row])
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARK: Spinner Methods
extension NewsController {
    private func startSpinner(){
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    private func stopSpinner(){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}

//MARK: Conform to ProfileServiceSubscriber
extension NewsController: ProfileServiceSubscriber {
    func refresh(model: ProfileModel) {
        //
    }
}
