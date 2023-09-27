//
//  ProfileService.swift
//  MyNews
//
//  Created by Ersan Shimshek on 27.09.2023.
//

import Foundation

//MARK: ProfileModel
struct ProfileModel: Codable {
    var favNews = [Article]()
    
}
//MARK: Subscriber Protocol - ProfileServiceSubscriber
protocol ProfileServiceSubscriber: AnyObject {
    func refresh(model: ProfileModel)
}

final class ProfileService {
    //MARK: Parameters
    public static let shared = ProfileService()
    private var subscribers = [ProfileServiceSubscriber]()
    private var model = ProfileModel()
    
    //MARK: Init
    private init(){
        model = FileService.shared.readModel()
    }
    //Model getter
    func getModel() -> [Article] {
        return model.favNews
    }
    
    //Subscribe a object
    func subscribe(subscriber: ProfileServiceSubscriber){
        subscribers.append(subscriber)
        subscriber.refresh(model: model)
    }
    //Add Elem
    func addItem(item: Article){
        model.favNews.append(item)
        refreshAll()
    }
    //Remove Elem
    func removeItem(elem: Article){
        model.favNews.removeAll { $0 == elem }
        refreshAll()
    }
    
    //Refresh the subscribers
    func refreshAll(){
        FileService.shared.writeModel(model: model)
        subscribers.map{
            $0.refresh(model: model)
        }
    }
}
