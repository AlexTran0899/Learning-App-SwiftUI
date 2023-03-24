//
//  ContentModel.swift
//  LearningApp
//
//  Created by Alex Tran on 3/23/23.
//

import Foundation
class ContentModel: ObservableObject {
    @Published var currentContentSelected: Int?
    @Published var lessonDescription = NSAttributedString()
    @Published var modules = [Module]()
    @Published var currModule: Module?
    var currModuleIndex = 0
    
    @Published var currLesson: Lesson?
    var currLessonIndex = 0
    
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
    // MARK: lesson navigation methods
    func beginLesson(_ lessonIndex: Int) {
        if lessonIndex < currModule!.content.lessons.count {
            currLessonIndex = lessonIndex
        } else {
            currLessonIndex = 0
        }
        currLesson = currModule?.content.lessons[currLessonIndex]
        lessonDescription = addStyling(currLesson!.explanation)
    }
    func hasNextLesson() -> Bool {
        if currModule?.content.lessons.count != nil {
            return currLessonIndex + 1 < currModule!.content.lessons.count
        }
        return false
    }
    
    func nextLesson() {
        currLessonIndex += 1
        if currLessonIndex < currModule!.content.lessons.count {
            currLesson = currModule!.content.lessons[currLessonIndex]
            lessonDescription = addStyling(currLesson!.explanation)
        } else {
            currLessonIndex = 0
            currLesson = nil
            lessonDescription = NSAttributedString()
        }
    }
    func nextLessonTitle() -> String {
        if hasNextLesson() {
            return currModule?.content.lessons[currLessonIndex + 1].title ?? ""
        }
        return ""
    }
    // code styling
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        // add the styling data
        data.append(styleData!)
        // add the html data
        data.append(Data(htmlString.utf8))
        // convert to attributed string
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            
                resultString = attributedString
        } catch {
            print(error)
        }
        
        return resultString
    }
}
