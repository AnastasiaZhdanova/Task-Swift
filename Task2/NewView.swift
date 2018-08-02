//
//  NewView.swift
//  Task2
//
//  Created by student on 8/2/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class NewView: UIView{
    
    //let  tapGestureRecognizer = UITapGestureRecognizer
    var currentView = UIView()
    //var currentView : UIView = []
    
    func createNewView(count: Double, mainView: UIView){
        var i = count
        
        var indent = 0
        currentView = mainView
        
        let width = 100
        let height = 150
        while i > 0 {
            var newView = UIView(frame: CGRect(x: indent, y: indent, width: width, height: height))
            
            newView.backgroundColor = .random
           
            currentView.addSubview(newView)
            
            currentView = newView
            indent = 10
            i = i - 1
        }
    }
    
    func deleteView(coordinate: CGPoint){
        let xyDeleteView = coordinate
        
        currentView.removeFromSuperview()
    }
}
    
//MARK: - Random Colour
extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
    
}
