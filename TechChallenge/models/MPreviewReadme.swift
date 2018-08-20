//
//  MPreviewReadme.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 20/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import Foundation

class MPreviewReadme{
    var readmeDecoded:String

    init?(json:Any) {
        guard

            let jsonMap:[String:Any] = json as? [String:Any]

            else{
                return nil
        }

        guard
            let data:String = jsonMap["content"] as? String
            else{
                return nil
        }

        let decodedData = Data(base64Encoded: data, options: .ignoreUnknownCharacters)!
        let decodedString = String(data: decodedData, encoding: .utf8)!

        print(decodedString)

        self.readmeDecoded = decodedString
    }
}
