//
//  CPreviewExtension.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

extension CPreviewController{
    private func requestImage(dispatchGroup:DispatchGroup, item:MWelcomeSearchItems){
        guard

            let request:URLRequest = CWelcomeController.factoryImageRequest(url:item.owner.avatarURL)

            else{
                return
        }

        dispatchGroup.enter()

        let task:URLSessionDownloadTask = session.downloadTask(
        with:request){
            [weak self] (downloadUrl:URL?, urlResponse:URLResponse?, error:Error?) in

            self?.requestImagesResponse(downloadUrl:downloadUrl, error:error, item:item)

            dispatchGroup.leave()
        }

        task.resume()
    }

    private func requestImagesResponse(downloadUrl:URL?, error:Error?, item:MWelcomeSearchItems){
        guard

            error == nil,
            let dataUrl:URL = downloadUrl,
            let image:UIImage = CWelcomeController.factoryImage(dataUrl:dataUrl)

            else{
                return
        }

        item.loadAvatarImage(image:image)
    }

    //MARK: internal
    //Reload data to show downloaded Images

    func requestImages(model:MWelcomeSearchItems){
        let dispatchGroup:DispatchGroup = CWelcomeController.factoryDispatchGroup()

        requestImage(
                dispatchGroup:dispatchGroup,
                item:model)

        dispatchGroup.notify(
            queue:DispatchQueue.global(
                qos:DispatchQoS.QoSClass.background))
        { [weak self] in

            self?.imageResponse(model: model)
        }
    }

    func requestReadmeFile(model:MWelcomeSearchItems){
        guard

            let request:URLRequest = CWelcomeController.factoryReadmeRequester(projectURL: model.fullName, projectBranch: model.defaultBranch)

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
                self?.requestReadmeResponse(data:data)
            }
        }

        task.resume()
    }

    private func requestReadmeResponse(data:Data?){
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

            let model:MPreviewReadme = MPreviewReadme(json:json)

            else{
                let error:String = NSLocalizedString("TestTaskerURLRequestErrorResponse_text", comment: "")
                print(error)

                return
        }

        DispatchQueue.main.async
            { [weak self] in

                self?.readmeResponse(model:model)
        }
    }

}
