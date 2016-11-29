//
//  main.swift
//  pickCandy
//
//  Created by 张俊凯 on 2016/11/29.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

import Foundation

private func showMeTheCandy(candy:String){
    print(candy)
}



let candys = ["a","b","c","d","e","f","g"]
print(candys)

showMeTheCandy(candy: candys[2])

var toPickCandyLocation = 5
var currentCandyLocation = 1
var candyPicked:String? = nil;


let candysTwo : Dictionary<String,String> = [
    "1" : "A",
    "2" : "B",
    "3" : "C",
    "4" : "D",
    "5" : "E",
    "6" : "F",
    "7" : "G",
    "8" : "H",
    "9" : "I"
]

showMeTheCandy(candy: candysTwo["2"]!)











