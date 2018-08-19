//
//  CWelcomeExtension.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import Foundation

//Extension for Data Request

extension CWelcomeController{
    func requestSearch(searchString:String){
        guard

            let request:URLRequest = CWelcomeController.factorySearchRequester(searchString: searchString)

            else{
                let error:String = NSLocalizedString("TestTaskerURLRequestError_text", comment: "")
                print(error)
                return
        }

        let task:URLSessionTask = session.dataTask(with:request){
            [weak self] (data:Data?, urlResponse:URLResponse?, error:Error?) in

            if let error:Error = error{
                print(error)
            }
            else{
                self?.requestLocationsResponse(data:data)
            }
        }

        task.resume()
    }

    private func requestLocationsResponse(data:Data?){
        guard

            let data:Data = data

            else{
                let error:String = NSLocalizedString("TestTaskerURLRequestErrorNoData_text", comment: "")
                print(error)

                return
        }

        let json:Any

        do{
            try json = JSONSerialization.jsonObject(
                with:data,
                options:JSONSerialization.ReadingOptions.allowFragments)
        }
        catch{
            let error:String = NSLocalizedString("TestTaskerURLRequestErrorParsing_text", comment: "")
            print(error)

            return
        }

        guard

            let model:MWelcomeSearch = MWelcomeSearch(json:json)

            else{
                let error:String = NSLocalizedString("TestTaskerURLRequestErrorResponse_text", comment: "")
                print(error)

                return
        }

        DispatchQueue.main.async
            { [weak self] in

                self?.searchResponse(model:model)
        }
    }
}
