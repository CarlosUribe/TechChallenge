//
//  VWelcomeView.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

class VWelcomeView:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate{
    weak var controller:CWelcomeController!
    weak var collection:UICollectionView!
    weak var topBar:VWelcomeViewBar!
    weak var searchBar:UITextField!
    private let kCornerRadius:CGFloat = 8.0
    private let kBarHeight:CGFloat = 88.0
    private let kCellConstantHeight:CGFloat = 120
    var model:MWelcomeSearch?

    convenience init(controller:CWelcomeController){
        self.init()
        self.controller = controller
        clipsToBounds = false
        backgroundColor = .white
        self.model = nil

        let topBar:VWelcomeViewBar = VWelcomeViewBar(controller: controller)
        self.topBar = topBar

        let searchBar:UITextField = UITextField()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.clipsToBounds = true
        searchBar.placeholder = "Search"
        searchBar.textAlignment = .center
        searchBar.backgroundColor = .white
        searchBar.clearButtonMode = .whileEditing
        searchBar.textColor = UIColor(red:0.42, green:0.48, blue:0.61, alpha:1)
        searchBar.layer.cornerRadius = kCornerRadius
        searchBar.delegate = self
        self.searchBar = searchBar

        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.minimumLineSpacing = 10
        flow.minimumInteritemSpacing = 10
        flow.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)

        let collection:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.dataSource = self
        collection.delegate = self
        collection.register(
            VWelcomeViewCell.self,
            forCellWithReuseIdentifier:
            VWelcomeViewCell.reusableIdentifier())
        self.collection = collection

        addSubview(topBar)
        addSubview(searchBar)
        addSubview(collection)

        let views:[String : Any] = [
            "bar":topBar,
            "search":searchBar,
            "collection":collection]

        let metrics:[String : CGFloat] = [
            "barHeight":kBarHeight]

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
            withVisualFormat:"H:|-20-[search]-20-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[bar]-0-[search(40)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[search]-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }

    //MARK: MODEL ITEM INDEX

    func getModelItem(index:Int) -> MWelcomeSearchItems{
        return (model?.item[index])!
    }

    //MARK: COLLECTION DELEGATES

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model != nil{
            guard
                let count:Int = model?.item.count
                else{
                    return 0
            }

            return count
        }
        else{
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model:MWelcomeSearchItems = getModelItem(index: indexPath.row)
        let cell:VWelcomeViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: VWelcomeViewCell.reusableIdentifier(),
            for:indexPath) as! VWelcomeViewCell
        cell.config(model:model)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismissKeyboard()

        
    }

    //MARK: FLOW DELEGATES

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width:CGFloat = UIScreen.main.bounds.width
        return CGSize(width: width, height: kCellConstantHeight)
    }

    //MARK: UITEXTFIELD DELEGATES

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let stringToSearch:String = textField.text! + string

        searchForString(string:stringToSearch)

        return true
    }

    //MARK: CONTROLLER CALLS

    func searchForString(string:String){
        DispatchQueue.global(qos: .background).async {
            [weak self] in
                self?.controller.makeSearchWithString(searchString:string)
        }
    }

    //MARK: KEYBOARD

    @objc func dismissKeyboard(){
        endEditing(true)
    }

    //MARK: SCROLL ACTION

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
}
