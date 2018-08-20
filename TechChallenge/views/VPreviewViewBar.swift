//
//  VPreviewViewBar.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

class VPreviewViewBar:UIView{
    weak var controller:CPreviewController!
    weak var labelTitle:UILabel!
    weak var backButton:UIButton!

    convenience init(controller:CPreviewController){
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        clipsToBounds = true
        isUserInteractionEnabled = false

        self.controller = controller
        let model:MWelcomeSearchItems = controller.model

        let labelTitle:UILabel = UILabel()
        labelTitle.clipsToBounds = true
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.numberOfLines = 0
        labelTitle.textAlignment = .center
        labelTitle.textColor = UIColor(red:0.16, green:0.39, blue:0.63, alpha:1.0)
        labelTitle.text = model.displayName

        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitleColor(.black, for: .normal)
        backButton.setTitle("<", for: .normal)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)

        addSubview(labelTitle)
        addSubview(backButton)

        let views:[String : Any] = [
            "back":backButton,
            "label":labelTitle]

        let metrics:[String : CGFloat] = [:]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-60-[label]-60-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-34-[label(20)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[back(50)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-34-[back(50)]",
            options:[],
            metrics:metrics,
            views:views))
    }

    //MARK: ACTIONS

    @objc func actionBack(sender button:UIButton){
        controller.parentController.pop()
    }
}
