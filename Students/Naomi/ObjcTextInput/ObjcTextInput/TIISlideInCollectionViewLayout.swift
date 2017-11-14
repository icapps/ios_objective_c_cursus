//
//  TIISlideInCollectionViewLayout.swift
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 13/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

import UIKit

class TIISlideInCollectionViewLayout: UICollectionViewFlowLayout {

    override func initialLayoutAttributesForAppearingItem(
        at itemIndexPath: IndexPath
        ) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        attributes?.transform = CGAffineTransform(translationX: -200.0, y: 0)


        return attributes
    }
}
