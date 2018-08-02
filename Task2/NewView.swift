//
//  NewView.swift
//  Task2
//
//  Created by student on 8/2/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class NewView: UIView {
    
  //  var currentView = UIView()
    
    func createNewView(count: Double, mainView: UIView){
        var i = count
        var stepHeight =  0.0
        var stepWidth = 0.0
        let indent = 10.0
        
        var width = Double(mainView.frame.size.width)/count
        var height = Double(mainView.frame.size.height)/count
        while i > 0 {
            var newView = UIView(frame: CGRect(x: stepWidth, y: stepHeight, width: width, height: height))
            
            newView.backgroundColor = .random
            mainView.addSubview(newView)
          //  currentView.addSubview(newView)
            
          //  currentView = newView
            
            stepHeight = stepHeight + indent
            stepWidth = stepWidth + indent
            
            i = i - 1
        }
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
