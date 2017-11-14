//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct Translation {
    var x: Int
    var y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    convenience init() {
        self.init(x: 1, y: 5)
    }
}

var array = [Translation(x:6, y: 10), Translation()]

var first = array[0]
first.x = 89

let array2 = array
