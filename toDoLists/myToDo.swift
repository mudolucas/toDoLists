//
//  MyToDo.swift
//  toDoList
//
//  Created by Lucas Mudo de Araujo on 7/12/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import Foundation

class ToDoItem: NSObject, NSCoding{
    
    var title:String
    var done:Bool
    var reward:Int
    
    public init(title: String, reward:String) {
        self.title = title
        self.done = false
        let rwd = Int(reward) ?? 0
        self.reward = rwd
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        // Try to unserialize the "title" variable
        if let title = aDecoder.decodeObject(forKey: "title") as? String, let reward = aDecoder.decodeObject(forKey: "reward") as? String
        {
            self.title = title
            let rwd = Int(reward) ?? 0
            self.reward = rwd
        }
        else
        {
            // There were no objects encoded with the key "title",
            // so that's an error.
            return nil
        }
        
        // Check if the key "done" exists, since decodeBool() always succeeds
        if aDecoder.containsValue(forKey: "done")
        {
            self.done = aDecoder.decodeBool(forKey: "done")
        }
        else
        {
            // Same problem as above
            return nil
        }
    }
    
    func encode(with aCoder: NSCoder)
    {
        // Store the objects into the coder object
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.done, forKey: "done")
    }
}

/*extension ToDoItem
{
    public class func getMockData() -> [ToDoItem]
    {
        return [
            ToDoItem(title: "Milk"),
            ToDoItem(title: "Chocolate"),
            ToDoItem(title: "Light bulb"),
            ToDoItem(title: "Dog food")
        ]
    }
}*/



// Creates an extension of the Collection type (aka an Array),
// but only if it is an array of ToDoItem objects.
extension Collection where Iterator.Element == ToDoItem
{
    // Builds the persistence URL. This is a location inside
    // the "Application Support" directory for the App.
    private static func persistencePath() -> URL?
    {
        let url = try? FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true)
        
        return url?.appendingPathComponent("todoitems.bin")
    }
    
    // Write the array to persistence
    func writeToPersistence() throws
    {
        if let url = Self.persistencePath(), let array = self as? NSArray
        {
            let data = NSKeyedArchiver.archivedData(withRootObject: array)
            try data.write(to: url)
        }
        else
        {
            throw NSError(domain: "com.mudolucas.toDoList", code: 10, userInfo: nil)
        }
    }
    
    // Read the array from persistence
    static func readFromPersistence() throws -> [ToDoItem]
    {
        if let url = persistencePath(), let data = (try Data(contentsOf: url) as Data?)
        {
            if let array = NSKeyedUnarchiver.unarchiveObject(with: data) as? [ToDoItem]
            {
                return array
            }
            else
            {
                throw NSError(domain: "com.mudolucas.toDoList", code: 11, userInfo: nil)
            }
        }
        else
        {
            throw NSError(domain: "com.mudolucas.toDoList", code: 12, userInfo: nil)
        }
    }
}
