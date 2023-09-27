//
//  NewsCell.swift
//  MyNews
//
//  Created by Ersan Shimshek on 27.09.2023.
//

import Foundation
import UIKit

final class NewsCell: UITableViewCell {
    //MARK: Cell Identifier
    static let cellID = "NewsCell"
    
    //MARK: Properties
    private let authorLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: Setup Components
extension NewsCell {
    private func setupCell(){
        contentView.backgroundColor = .white
        
        //Date Label
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        dateLabel.text = "2023-09-27"
        dateLabel.textColor = .black
        dateLabel.textAlignment = .right
        dateLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 10)
        NSLayoutConstraint.activate([
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            dateLabel.widthAnchor.constraint(equalToConstant: 150),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
            
        ])
        
        //Author Label
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorLabel)
        authorLabel.text = "Test Author"
        authorLabel.textColor = .black
        authorLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        NSLayoutConstraint.activate([
            authorLabel.heightAnchor.constraint(equalToConstant: 20),
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            authorLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -5)
            
        ])
        
        //Desription Label
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        descriptionLabel.text = " Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."
        descriptionLabel.font = UIFont(name: "Baskerville", size: 15)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .black
        NSLayoutConstraint.activate([
            descriptionLabel.heightAnchor.constraint(equalToConstant: 60),
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
            
        ])
    }
}
extension NewsCell {
    //Config Cell
    func config(author: String, desc: String, date: String) {
        authorLabel.text = author
        descriptionLabel.text = desc
        dateLabel.text = date
    }
}
