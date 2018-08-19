//
//  CategoryUICollectionReusableView.swift
//  TechChallenge
//
//  Created by Carlos Uribe on 19/08/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit

extension UICollectionReusableView{
    class func reusableIdentifier() -> String{
        let classType:AnyClass = object_getClass(self)!

        return NSStringFromClass(classType)
    }
}
