//
//  NewsModel.swift
//  MyNews
//
//  Created by Ersan Shimshek on 27.09.2023.
//

import Foundation

struct Articles: Codable, Hashable {
    let articles: [Article]?
}
struct Article: Codable, Hashable {
    let author: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}
