//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


//1 Derived collections of enum cases
//This automatic synthesis of allCases will only take place for enums that do not use associated values.
//At this time, Swift is unable to synthesize the allCases property if any of your enum cases are marked unavailable.
do {
    enum Animal : CaseIterable {
        case dog, cat, fish
    }
    
    for i in Animal.allCases {
        print(i)
    }
    
}

// 2 Warning and error diagnostic directives
//Both #warning and #error work alongside the existing #if compiler directive,
do {
    #warning("哈哈哈")
    #error("出错了")
    
}
