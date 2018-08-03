//
//  NewView.swift
//  Task2
//
//  Created by student on 8/2/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class NewView: UIView, UIGestureRecognizerDelegate{
    
    var currentView = UIView()
    static var defView = UIView()
    
    override init(frame: CGRect){
       super.init(frame: frame)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createNewView(count: Double, mainView: UIView){
        var i = count
        
        var indent = 0
        currentView = mainView
        NewView.defView = mainView
        let width = 100
        let height = 150
        while i > 0 {
            var newView =  NewView(frame: CGRect(x: indent, y: indent, width: width, height: height))
            
            newView.backgroundColor = .random
           
            currentView.addSubview(newView)
            
            currentView = newView
            indent = 10
            i = i - 1
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.point(inside: point, with: event) {
            return super.hitTest(point, with: event)
        }
        guard isUserInteractionEnabled, !isHidden, alpha > 0 else {
            return nil
        }
        
        for subview in subviews.reversed() {
            let convertedPoint = subview.convert(point, from: self)
            if let hitView = subview.hitTest(convertedPoint, with: event) {
                return hitView
            }
        }
        return nil
    }
    
    @objc func handleTap(sender: UIGestureRecognizer) {
        let tempView = self.superview
        if superview == NewView.defView {
            for subview in self.subviews{
                subview.frame.origin.x = 0
                subview.frame.origin.y = 0
                NewView.defView.addSubview(subview)
            }
        } else {
            for subview in self.subviews{
                tempView?.addSubview(subview)
            }
        }
        self.removeFromSuperview()
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
