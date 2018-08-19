//
//  CWelcomeController.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

class CWelcomeController:UIViewController{
    weak var welcomeView:VWelcomeView!

    override func loadView() {
        let welcomeView:VWelcomeView = VWelcomeView(controller:self)
        self.welcomeView = welcomeView
        view = welcomeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        extendedLayoutIncludesOpaqueBars = false
    }

    override var preferredStatusBarStyle:UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

    override var prefersStatusBarHidden:Bool{
        return false
    }

    //MARK: REQEUST CALLS

    func makeSearchWithString(searchString:String){}
}
