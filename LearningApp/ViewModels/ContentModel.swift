//
//  ContentModel.swift
//  LearningApp
//
//  Created by Alex Tran on 3/23/23.
//

import Foundation
class ContentModel: ObservableObject {
    @Published var modules = [Module]()
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    func getLocalData() {
        // get the url to json file
        let pathString = Bundle.main.url(forResource: "data", withExtension: "json")
        // read the file into a data object
        do {
            let jsonData = try Data(contentsOf: pathString!)
            do {
                // decode json data into an array of module
                let decoder = JSONDecoder()
                let parsedData = try decoder.decode([Module].self, from: jsonData)
                self.modules = parsedData
            } catch {
                print(error)
            }
        } catch {
            print("couldn't parse local data")
        }
        
        let styleURLString = Bundle.main.url(forResource: "style", withExtension: "html")
        do {
            let styleData = try Data(contentsOf: styleURLString!)
            self.styleData = styleData
        } catch {
            print("couldn't parse local data style")
        }
    }
}
