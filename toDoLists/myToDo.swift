//
//  MyToDo.swift
//  toDoList
//
//  Created by Lucas Mudo de Araujo on 7/12/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import Foundation

class Quests{
    
    var title:String
    var done:Bool
    var reward:Int
    
    public init(title: String, reward:String) {
        self.title = title
        self.done = false
        let rwd = Int(reward) ?? 0
        self.reward = rwd
    }
    
    
}
/*extension Quests
{
    public class func getMockData() -> Array<Quests>
    {
        return [[Quests(title: "Quest1", reward: "10")],[Quests(title: "Quest2", reward: "20")]]
    }
}*/
