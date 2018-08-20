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
}
