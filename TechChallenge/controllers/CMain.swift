//
//  CMain.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

import UIKit

class CMain:UIViewController{
    let interaction:CMainControllerInteraction
    var transition:CMainControllerTransition?
    private var statusBarStyle:UIStatusBarStyle

    init(){
        interaction = CMainControllerInteraction()
        statusBarStyle = UIStatusBarStyle.lightContent

        super.init(nibName:nil, bundle:nil)

        let mainController:CWelcomeController = CWelcomeController()
        let transition:CMainControllerTransition = CMainControllerTransition.Replace(
            controller:mainController)
        transitionTo(transition:transition)
    }

    required init?(coder:NSCoder){
        fatalError()
    }

    override var preferredStatusBarStyle:UIStatusBarStyle{
        return statusBarStyle
    }

    override var prefersStatusBarHidden:Bool{
        return false
    }

    //MARK: public

    func transitionTo(transition:CMainControllerTransition){
        UIApplication.shared.keyWindow?.endEditing(true)
        transition.startTransition(main:self)
    }

    func pop(){
        UIApplication.shared.keyWindow?.endEditing(true)
        transition?.pop()
    }

    func statusBarLight(){
        statusBarStyle = UIStatusBarStyle.lightContent
        setNeedsStatusBarAppearanceUpdate()
    }

    func statusBarDefault(){
        statusBarStyle = UIStatusBarStyle.default
        setNeedsStatusBarAppearanceUpdate()
    }
}
