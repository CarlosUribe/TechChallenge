//
//  RWelcomeRequest.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

    //Factory method for Network handling

extension CWelcomeController{
    private static let kTimeOutData:TimeInterval = 50
    private static let kTimeOutImage:TimeInterval = 150
    private static let kGETRequest:String = "GET"
    private static let kResourceName:String = "urlList"
    private static let kResourceExtension:String = "plist"
    private static let kUrlServer:String = "testServer"
    private static let kUrlSearchApp:String = "app"
    private static let kUrlLocationsData:String = "testData"
    private static let kUrlImageData:String = "imageData"

    //Session configuration

    private class func factoryConfiguration() -> URLSessionConfiguration{
        let configuration:URLSessionConfiguration = URLSessionConfiguration.ephemeral
        configuration.allowsCellularAccess = true
        configuration.isDiscretionary = true
        configuration.networkServiceType = URLRequest.NetworkServiceType.default
        configuration.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData

        return configuration
    }

    //Type of Request configuration

    class func factoryDataRequest(url:URL) -> URLRequest{
        var request:URLRequest = URLRequest(
            url:url,
            cachePolicy:
            URLRequest.CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval:kTimeOutData)
        request.httpMethod = kGETRequest
        request.allowsCellularAccess = true

        return request
    }

    //MARK:LOCATION REQUESTER

    class func factorySearchRequester(searchString:String) -> URLRequest?{
        guard

            let url:URL = factorySearchURL(searchString: searchString)

            else{
                return nil
        }

        let request:URLRequest = factoryDataRequest(url:url)

        return request
    }

    //Creation of URL to be requested

    class func factorySearchURL(searchString:String) -> URL?{
        guard

            let urlMap:[String:String] = factoryUrl(),
            let urlServer:String = urlMap[kUrlServer],
            let urlSearch:String = urlMap[kUrlSearchApp]

            else{
                return nil
        }

        var compositeUrl:String = String()
        compositeUrl.append(urlServer)
        compositeUrl.append(String(format: urlSearch, searchString))

        let url:URL? = URL(string:compositeUrl)

        return url
    }

    private class func factoryUrl() -> [String:String]?{
        let podBundle:Bundle = Bundle(
            for:CWelcomeController.self)

        guard

            let resourceUrl:URL = podBundle.url(
                forResource:kResourceName,
                withExtension:kResourceExtension),
            let urlDictionary:NSDictionary = NSDictionary(
                contentsOf:resourceUrl)

            else{
                return nil
        }

        let urlMap:[String:String]? = urlDictionary as? [String:String]

        return urlMap
    }

    //Creation of group to provide synchronization

    class func factoryDispatchGroup() -> DispatchGroup{
        let dispatchGroup:DispatchGroup = DispatchGroup()
        dispatchGroup.setTarget(
            queue:DispatchQueue.global(
                qos:DispatchQoS.QoSClass.background))

        return dispatchGroup
    }

    class func factorySession() -> URLSession{
        let configuration:URLSessionConfiguration = factoryConfiguration()
        let urlSession:URLSession = URLSession(configuration:configuration)

        return urlSession
    }

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
        guard

            let urlMap:[String:String] = factoryUrl(),
            let urlServer:String = urlMap[kUrlServer],
            let urlLocations:String = urlMap[kUrlImageData]

            else{
                return nil
        }

        let urlImage:String = alias
        var compositeUrl:String = String()
        compositeUrl.append(urlServer)
        compositeUrl.append(urlLocations)
        compositeUrl.append(urlImage)

        let url:URL? = URL(string:compositeUrl)

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
