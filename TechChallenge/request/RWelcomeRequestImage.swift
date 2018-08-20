//
//  RWelcomeRequestImage.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

extension CWelcomeController{
    private static let kTimeOutImage:TimeInterval = 150
    private static let kGETRequest:String = "GET"
    
    //MARK: IMAGE REQUESTER

    class func factoryImageRequest(url:String) -> URLRequest?{
        guard

            let url:URL = factoryImageURL(alias: url)

            else{
                return nil
        }

        var request:URLRequest = URLRequest(
            url:url,
            cachePolicy:
            URLRequest.CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval:kTimeOutImage)
        request.httpMethod = kGETRequest
        request.allowsCellularAccess = true

        return request
    }

    class func factoryImageURL(alias:String) -> URL?{
        let urlImage:String = alias
        let url:URL? = URL(string:urlImage)

        return url
    }

    class func factoryImage(dataUrl:URL) -> UIImage?{
        let rawData:Data

        do{
            try rawData = Data(
                contentsOf:dataUrl)
        }
        catch{
            return nil
        }

        let image:UIImage? = UIImage(
            data:rawData)

        return image
    }
}



