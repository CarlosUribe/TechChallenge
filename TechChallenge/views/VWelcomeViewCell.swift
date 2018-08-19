//
//  VWelcomeViewCell.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

class VWelcomeViewCell:UICollectionViewCell{
    weak var titleProject:UILabel!
    weak var starProject:UILabel!
    weak var descriptionProject:UILabel!
    weak var model:MWelcomeSearchItems!

    override init(frame:CGRect){
        super.init(frame:frame)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white

        let titleProject:UILabel = UILabel()
        titleProject.clipsToBounds = true
        titleProject.translatesAutoresizingMaskIntoConstraints = false
        titleProject.numberOfLines = 0
        titleProject.textAlignment = .left
        titleProject.font = UIFont.systemFont(ofSize: 16, weight: .black)
        titleProject.textColor = UIColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
        self.titleProject = titleProject

        let starProject:UILabel = UILabel()
        starProject.clipsToBounds = true
        starProject.translatesAutoresizingMaskIntoConstraints = false
        starProject.numberOfLines = 0
        starProject.textAlignment = .left
        starProject.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        starProject.textColor = UIColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
        self.starProject = starProject

        let descriptionProject:UILabel = UILabel()
        descriptionProject.clipsToBounds = true
        descriptionProject.translatesAutoresizingMaskIntoConstraints = false
        descriptionProject.numberOfLines = 0
        descriptionProject.textAlignment = .left
        descriptionProject.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionProject.textColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.0)
        self.descriptionProject = descriptionProject

        addSubview(titleProject)
        addSubview(starProject)
        addSubview(descriptionProject)

        let views:[String : Any] = [
            "title":titleProject,
            "start":starProject,
            "description":descriptionProject]

        let metrics:[String : CGFloat] = [:]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[title]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-5-[title(20)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[start]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[title]-0-[start(20)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[description]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[start]-0-[description]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(model:MWelcomeSearchItems){
        self.model = model

        self.titleProject.text = model.displayName
        self.starProject.text = "Stars: \(model.starGazer)"
        self.descriptionProject.text = model.description
    }
}
