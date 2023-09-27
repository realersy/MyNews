//
//  FileService.swift
//  MyNews
//
//  Created by Ersan Shimshek on 27.09.2023.
//

import Foundation

final class FileService {
    //MARK: Properties
    public static let shared = FileService()
    //MARK: Private Init
    private init(){}
    
    //MARK: Write a ProfileModel onto the file
    func writeModel(model: ProfileModel){
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("cannot access documents directory")
            return
        }
        let fileURL = documentsURL.appendingPathComponent("saved")
        do {
            let data = try JSONEncoder().encode(model)
            try data.write(to: fileURL)
        } catch {
            print("cannot write to file")
        }
    }
    //MARK: Reads ProfileModel from the file
    func readModel() -> ProfileModel {
        guard let documentsURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            return ProfileModel()
        }
        let fileURL = documentsURL.appendingPathComponent("saved")
        do {
            let data = try Data(contentsOf: fileURL)
            let object = try JSONDecoder().decode(ProfileModel.self, from: data)
            return object
            
        } catch {
            return ProfileModel()
        }
    }
}
