//
//  Constants.swift
//  Targeter
//
//  Created by mac on 12/3/17.
//  Copyright © 2017 Alder. All rights reserved.
//

import Foundation

struct Constants {
    struct UserData {
        static let Name = "name"
        static let City = "city"
        static let Age = "age" //dep
        static let About = "about"
        static let ImageURL = "imageURL"
        static let Username = "username"
        static let UsernameLowercased = "username_lowercased"
        static let Percentage = "percentage"
        static let Email = "email"
    }
    struct Target {
        static let TargetID = "targetID"
        static let Title = "title"
        static let Description = "description" //dep
        static let Percentage = "percentage"
        static let Started = "started" //dep
        static let Completed = "completed"
        static let ImageURL = "imageURL" // dep
        static let ImageUrlString = "imageUrlString"
        static let Checkins = "checkins"
        static let DateBeginning = "dateBeginning" //dep
        static let Start = "start"
        static let DateEnding = "dateEnding" //dep
        static let Uid = "uid"
        static let Timestamp = "timestamp"
    }
    struct CheckIn {
        static let Result = "result"
        static let Timestamp = "timestamp"
    }
    
    struct RootFolders {
        static let Users = "users"
        static let Targets = "targets" //dep
        static let NewTargets = "newtargets"
        static let User_Target = "user_target"
        static let CheckIns = "checkins"
    }
}
