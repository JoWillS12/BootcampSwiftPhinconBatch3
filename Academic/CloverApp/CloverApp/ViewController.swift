//
//  ViewController.swift
//  CloverApp
//
//  Created by Joseph William Santoso on 27/11/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

//extension Array{
//    func walk(_ block: (Element, Int) -> Void){
//        for (index, element) in enumerated(){
//            if let subArray = element as? [Element]{
//                subArray.walk(block)
//            }else{block(element, index)}
//        }
//    }
//}
//
//let stdout = ProcessInfo.processInfo.environment["OUTPUT_PATH"]!
//FileManager.default.createFile(atPath: stdout, contents: nil, attributes: nil)
//let fileHandle = FileHandle(forWritingAtPath: stdout)!
//
//guard let input = readLine() else { fatalError("Bad input") }
//let tokenized = input.split(separator: " ")
//
//var array : [Any] = []
//var indexKeys : [Int] = []
//var subarrays : [Int:[Any]] = [:]
//var depth = 0
//
//for i in 0..<tokenized.count {
//    let token = String(tokenized[i])
//    if token == "[" {
//        subarrays[i] = []
//        indexKeys.append(i)
//    }
//    else if token == "]" {
//        let expiringKey = indexKeys.popLast()
//        if let subarray = subarrays[expiringKey!] {
//            if indexKeys.isEmpty {
//                array.append(subarray)
//            } else {
//                let key = indexKeys.last!
//                subarrays[key]?.append(subarray)
//            }
//        }
//    }
//    else {
//        if indexKeys.isEmpty {
//            array.append(token)
//        } else {
//            let key = indexKeys.last!
//            subarrays[key]?.append(token)
//        }
//    }
//}
//
//var res : [String] = []
//array.walk { (value, index) in
//    res.append("\(index) \(value)")
//}
//
//fileHandle.write(res.joined(separator: "\n").data(using: .utf8)!)
//fileHandle.write("\n".data(using: .utf8)!)
