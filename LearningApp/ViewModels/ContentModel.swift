//
//  ContentModel.swift
//  LearningApp
//
//  Created by Alex Tran on 3/23/23.
//

import Foundation
class ContentModel: ObservableObject {
    @Published var modules = [Module]()
    @Published var currModule: Module?
    var currModuleIndex = 0
    
    var styleData: Data?
    init() {
        getLocalData()
    }
    // MARK: Data Method
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
    // MARK: Module navigation methods
    func beginModule(_ moduleId: Int) {
        // Find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                currModuleIndex = index
                break
            }
        }
        // Set the current module
        currModule = modules[currModuleIndex]
    }
}
