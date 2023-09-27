//
//  FavouritesController.swift
//  MyNews
//
//  Created by Ersan Shimshek on 27.09.2023.
//

import Foundation
import UIKit

class FavouritesController: UIViewController {
    //MARK: Properties
    let favTableView = UITableView()
    var favArticles = [Article]()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setup()
    }
}

//MARK: Setup
extension FavouritesController {
    private func setup(){
        view.addSubview(favTableView)
        favTableView.translatesAutoresizingMaskIntoConstraints = false
        favTableView.dataSource = self
        favTableView.delegate = self
        favTableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.cellID)
        favTableView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            favTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            favTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

//MARK: UITableViewDataSource, UITableViewDelegate
extension FavouritesController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTableView.dequeueReusableCell(withIdentifier: NewsCell.cellID, for: indexPath) as! NewsCell
        cell.config(author: favArticles[indexPath.row].author ?? "Unknown Author",
                    desc: favArticles[indexPath.row].description ?? "No description",
                    date: favArticles[indexPath.row].publishedAt?.trim() ?? "0-0")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailsController(article: favArticles[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: Conform to ProfileServiceSubscriber
extension FavouritesController: ProfileServiceSubscriber {
    func refresh(model: ProfileModel) {
        favArticles = model.favNews
        favTableView.reloadData()
    }
}
