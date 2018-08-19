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

    convenience init(controller:CPreviewController){
        self.init()
        self.controller = controller
        clipsToBounds = false
        backgroundColor = .white

    }
}
