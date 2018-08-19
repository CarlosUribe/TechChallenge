//
//  CPreviewController.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

class CPreviewController:UIViewController{
    weak var previewView:VPreviewView!
    let session:URLSession

    init(model:MWelcomeSearchItems){
        session = CWelcomeController.factorySession()
        super.init(nibName:nil, bundle:nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let previewView:VPreviewView = VPreviewView(controller:self)
        self.previewView = previewView
        view = previewView
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

    //TODO: IMPLEMENT IMAGE REQUESTER
}