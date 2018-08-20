//
//  VPreviewView.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

class VPreviewView:UIView{
    weak var controller:CPreviewController!
    weak var topBar:VPreviewViewBar!
    weak var avatarImage:UIImageView!
    weak var userName:UILabel!
    weak var descriptionProject:UILabel!
    weak var stars:UILabel!
    weak var fork:UILabel!
    weak var readmeDescription:UITextView!
    weak var model:MWelcomeSearchItems!
    private let kCornerRadiusForImage:CGFloat = 50
    private let kCornerRadiusForLabel:CGFloat = 5
    private let kBarHeight:CGFloat = 88.0

    convenience init(controller:CPreviewController){
        self.init()
        self.controller = controller
        clipsToBounds = false
        backgroundColor = .white

        let model:MWelcomeSearchItems = controller.model
        self.model = model

        let topBar:VPreviewViewBar = VPreviewViewBar(controller: controller)
        self.topBar = topBar

        let headerView:UIView = UIView()
        headerView.clipsToBounds = true
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.94, alpha:0.6)

        let middleView:UIView = UIView()
        middleView.clipsToBounds = true
        middleView.translatesAutoresizingMaskIntoConstraints = false
        middleView.backgroundColor = .white

        let bottomView:UIView = UIView()
        bottomView.clipsToBounds = true
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .white

        let avatarImage:UIImageView = UIImageView()
        avatarImage.clipsToBounds = true
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.layer.cornerRadius = kCornerRadiusForImage
        self.avatarImage = avatarImage

        let userName:UILabel = UILabel()
        userName.clipsToBounds = true
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.numberOfLines = 0
        userName.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        userName.textColor = UIColor(red:1.00, green:0.45, blue:0.20, alpha:1.0)
        userName.text = self.model.owner.login
        userName.textAlignment = .center
        self.userName = userName

        let descriptionProject:UILabel = UILabel()
        descriptionProject.clipsToBounds = true
        descriptionProject.translatesAutoresizingMaskIntoConstraints = false
        descriptionProject.numberOfLines = 0
        descriptionProject.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionProject.textColor = UIColor(red:0.69, green:0.69, blue:0.72, alpha:1.0)
        descriptionProject.text = self.model.description
        descriptionProject.textAlignment = .center
        self.descriptionProject = descriptionProject

        let stars:UILabel = UILabel()
        stars.clipsToBounds = true
        stars.translatesAutoresizingMaskIntoConstraints = false
        stars.numberOfLines = 0
        stars.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        stars.textColor = UIColor(red:0.16, green:0.39, blue:0.63, alpha:1.0)
        stars.text = String(format: NSLocalizedString("VPreviewView_stars", comment: ""), "\(self.model.starGazer)")
        stars.layer.cornerRadius = kCornerRadiusForLabel
        stars.layer.borderColor = UIColor(red:0.16, green:0.39, blue:0.63, alpha:1.0).cgColor
        stars.layer.borderWidth = 1
        stars.textAlignment = .center
        self.stars = stars

        let fork:UILabel = UILabel()
        fork.clipsToBounds = true
        fork.translatesAutoresizingMaskIntoConstraints = false
        fork.numberOfLines = 0
        fork.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        fork.textColor = UIColor(red:0.16, green:0.39, blue:0.63, alpha:1.0)
        fork.text = String(format: NSLocalizedString("VPreviewView_forks", comment: ""), "\(self.model.forkCount)")
        fork.layer.cornerRadius = kCornerRadiusForLabel
        fork.layer.borderColor = UIColor(red:0.16, green:0.39, blue:0.63, alpha:1.0).cgColor
        fork.layer.borderWidth = 1
        fork.textAlignment = .center
        self.fork = fork

        let readme:UILabel = UILabel()
        readme.clipsToBounds = true
        readme.translatesAutoresizingMaskIntoConstraints = false
        readme.numberOfLines = 0
        readme.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        readme.textColor = UIColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
        readme.text = NSLocalizedString("VPreviewView_readmeTag", comment: "")

        let readmeDescription:UITextView = UITextView()
        readmeDescription.clipsToBounds = true
        readmeDescription.translatesAutoresizingMaskIntoConstraints = false
        readmeDescription.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        readmeDescription.textColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.0)
        readmeDescription.textAlignment = .left
        readmeDescription.text = "Readme.md"
        self.readmeDescription = readmeDescription

        headerView.addSubview(avatarImage)
        headerView.addSubview(userName)
        headerView.addSubview(descriptionProject)
        middleView.addSubview(stars)
        middleView.addSubview(fork)
        bottomView.addSubview(readme)
        bottomView.addSubview(readmeDescription)

        addSubview(topBar)
        addSubview(headerView)
        addSubview(bottomView)
        addSubview(middleView)

        let views:[String : Any] = [
            "bar":topBar,
            "header":headerView,
            "middle":middleView,
            "bottom":bottomView,
            "avatar":avatarImage,
            "name":userName,
            "description":descriptionProject,
            "stars":stars,
            "fork":fork,
            "readme":readme,
            "readmeDescription":readmeDescription]

        let width:CGFloat = (UIScreen.main.bounds.width / 2) - 50
        let metrics:[String : CGFloat] = [
            "barHeight":kBarHeight,
            "width":width]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[bar(barHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[header]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[bar]-0-[header(250)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-50-[middle]-50-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[header]-(-20)-[middle(30)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[middle]-(-20)-[bottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-width-[avatar]-width-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[avatar(100)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[name]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[avatar]-0-[name(20)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[description]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[name]-0-[description]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[fork(width)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[stars(width)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[stars(30)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[fork(30)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[readme]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-30-[readme(20)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[readmeDescription]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[readme]-0-[readmeDescription]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}
