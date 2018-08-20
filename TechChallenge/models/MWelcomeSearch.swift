//
//  MWelcomeSearch.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import Foundation

class MWelcomeSearch{
    var item:[MWelcomeSearchItems]

    init?(json:Any) {
        guard

            let jsonMap:[String:Any] = json as? [String:Any]

            else{
                return nil
        }

        var items:[MWelcomeSearchItems] = []

        guard
        let itemsInResult:[[String : Any]] = jsonMap["items"] as? [[String : Any]]
            else{
                return nil
        }

        for result:Any in itemsInResult{
            guard

                let item:MWelcomeSearchItems = MWelcomeSearchItems(json:result)

                else{
                    continue
            }

            items.append(item)
        }

        guard

            items.count > 0

            else{
            return nil
        }

        self.item = items
    }
}
