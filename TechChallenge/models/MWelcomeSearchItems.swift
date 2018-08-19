//
//  MWelcomeSearchItems.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import Foundation

class MWelcomeSearchItems{
    var displayName:String
    var id:Int
    var nodeID:String
    var fullName:String
    var owner:MWelcomeOwner
    var privateStatus:Bool
    var projectURL:String
    var description:String
    var forkStatus:Bool
    var apiURL:String
    var createdDate:String
    var updatedDate:String
    var pushedDate:String
    var starGazer:Int
    var watchers:Int
    var forkCount:Int
    var defaultBranch:String
    var score:Double

    init?(json:Any) {
        guard
            let rawItem:[String:Any] = json as? [String:Any],
            let rawDisplayName:String  = rawItem["name"] as? String,
            let rawID:Int = rawItem["id"] as? Int,
            let rawNodeID:String = rawItem["node_id"] as? String,
            let rawFullName:String = rawItem["full_name"] as? String,
            let rawOwner:[String : Any] = rawItem["owner"] as? [String : Any],
            let rawPrivateStatus:Bool = rawItem["private"] as? Bool,
            let rawProjectURL:String = rawItem["html_url"] as? String,
            let rawDescription:String = rawItem["description"] as? String,
            let rawForkStatus:Bool = rawItem["fork"] as? Bool,
            let rawApiURL:String = rawItem["url"] as? String,
            let rawCreatedAt:String = rawItem["created_at"] as? String,
            let rawUpdatedAt:String = rawItem["updated_at"] as? String,
            let rawPushedAt:String = rawItem["pushed_at"] as? String,
            let rawStargazers:Int = rawItem["stargazers_count"] as? Int,
            let rawWatchers:Int = rawItem["watchers_count"] as? Int,
            let rawForkCount:Int = rawItem["forks_count"] as? Int,
            let rawDefaultBranch:String = rawItem["default_branch"] as? String,
            let rawScore:Double = rawItem["score"] as? Double

            else{
                return nil
        }

        self.displayName = rawDisplayName
        self.id = rawID
        self.nodeID = rawNodeID
        self.fullName = rawFullName
        self.owner = MWelcomeOwner(json: rawOwner)!
        self.privateStatus = rawPrivateStatus
        self.projectURL = rawProjectURL
        self.description = rawDescription
        self.forkStatus = rawForkStatus
        self.apiURL = rawApiURL
        self.createdDate = rawCreatedAt
        self.updatedDate = rawUpdatedAt
        self.pushedDate = rawPushedAt
        self.starGazer = rawStargazers
        self.watchers = rawWatchers
        self.forkCount = rawForkCount
        self.defaultBranch = rawDefaultBranch
        self.score = rawScore
    }
}
