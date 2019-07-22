//
//  MyToDo.swift
//  toDoList
//
//  Created by Lucas Mudo de Araujo on 7/12/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
//

import Foundation

private enum Frequency{
    case everyday
    case one_time_only
    case weekly
}

private enum Status{
    case active
    case completed
    case expired
}
class Quests{
    // MAKE IT PRIVATE AND SET GETTERS AND SETTERS
    //private var status:Status
    //private var frequency:Frequency
    var title:String
    var done:Bool
    var reward:Int
    // Data Created
    //Data Completed
    // ACITVE DATE RANGE
    
    public init(title: String, reward:String) {
        self.title = title
        self.done = false
        let rwd = Int(reward) ?? 0
        self.reward = rwd
    }
    
}
