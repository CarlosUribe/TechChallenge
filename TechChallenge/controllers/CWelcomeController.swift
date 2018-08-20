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
    let session:URLSession

    init(controller:CMain){
        session = CWelcomeController.factorySession()
        super.init(nibName:nil, bundle:nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    func makeSearchWithString(searchString:String){
        requestSearch(searchString:searchString)
    }

    //MARK: RESPONSE

    func searchResponse(model:MWelcomeSearch){
        DispatchQueue.main.async {
            [weak self] in
            self?.welcomeView.model = model
            self?.welcomeView.collection.reloadData()
        }
    }

    //MARK: TRANSITIONS

    func transitionTo(model:MWelcomeSearchItems){
        let controller:CPreviewController = CPreviewController(model:model)
        let transition:CMainControllerTransition = CMainControllerTransition.pushRight(
            controller:controller,
            poptype:
            CMainControllerTransition.CMainControllerTransitionPoptype.none
        )

        parentController.transitionTo(transition:transition)
    }
}
