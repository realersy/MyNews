//
//  NewsService.swift
//  MyNews
//
//  Created by Ersan Shimshek on 27.09.2023.
//

import Foundation

final class NewsService {
    
    //MARK: Singlton
    public static let shared = NewsService()
    
    //MARK: Init
    private init(){}
    
    //MARK: Gets News Web
    func getNews(_ completion: @escaping ([Article]) -> Void) {
        let newsURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=8a7e7d2baee940a7ae641be869413cd4"
        
        guard let url = URL(string: newsURL) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            UserDefaults.standard.setValue(data, forKey: "tempData")
            let model = try! JSONDecoder().decode(Articles.self, from: data!)
            DispatchQueue.main.async {
                completion(model.articles!)
            }
        }.resume()
    }
    //MARK: Gets Image From Web
    func getImage(url: String, _ completion: @escaping (Data) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        URLSession.shared.dataTask(with: request) { data, response, error  in
            guard let data = data else { return }
            completion(data)
        }.resume()
    }
}
