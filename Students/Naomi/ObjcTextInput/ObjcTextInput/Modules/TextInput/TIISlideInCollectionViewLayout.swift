//
//  TIISlideInCollectionViewLayout.swift
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 13/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

import UIKit

class Translation: NSObject {
    @objc var x: CGFloat
    @objc var y: CGFloat

    @objc init(x: CGFloat, y: CGFloat) {
        self.x = x
        self.y = y
    }
    @objc override init() {
        self.x = -200.0
        self.y = 0
        super.init()
    }
}

class TIISlideInCollectionViewLayout: UICollectionViewFlowLayout {

    @objc var translation: Translation = Translation()

    override func initialLayoutAttributesForAppearingItem(
        at itemIndexPath: IndexPath
        ) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        attributes?.transform = CGAffineTransform(translationX: translation.x, y: translation.y)


        return attributes
    }
}
