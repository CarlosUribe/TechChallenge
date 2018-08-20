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
    var model:MWelcomeSearchItems!

    init(model:MWelcomeSearchItems){
        self.model = model
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

        requestImages(model: self.model)
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

    func imageResponse(model:MWelcomeSearchItems){
        DispatchQueue.main.async {
            [weak self] in
                self?.previewView.avatarImage.image = model.avatarImage
        }
    }
}
