//
//  CMainControllerTransitionReplace.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

class  CMainControllerTransitionReplace:CMainControllerTransition{
    override func startTransition(main:CMain){
        main.addChildViewController(controller)
        main.view.addSubview(controller.view)
        controller.view.frame = main.view.bounds
        controller.didMove(toParentViewController:main)

        super.startTransition(main:main)

        popAllPrevious()
        previousTransition = nil
    }
}
