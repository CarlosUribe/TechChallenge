//
//  MWelcomeOwner.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import Foundation

class MWelcomeOwner{
    var login:String
    var id:Int
    var nodeID:String
    var avatarURL:String
    var userURL:String
    var eventsURL:String
    var htmlURL:String
    var type:String

    init?(json:[String : Any]) {
        guard
            let rawLogin:String = json["login"] as? String,
            let rawID:Int = json["id"] as? Int,
            let rawNodeID:String = json["node_id"] as? String,
            let rawAvatarURL:String = json["avatar_url"] as? String,
            let rawUserURL:String = json["url"] as? String,
            let rawEventsURL:String = json["received_events_url"] as? String,
            let rawType:String = json["type"] as? String,
            let rawHtmlURL:String = json["html_url"] as? String

            else{
                return nil
        }

        self.login = rawLogin
        self.id = rawID
        self.nodeID = rawNodeID
        self.avatarURL = rawAvatarURL
        self.userURL = rawUserURL
        self.eventsURL = rawEventsURL
        self.type = rawType
        self.htmlURL = rawHtmlURL
    }
}
