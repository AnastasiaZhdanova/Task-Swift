//
//  NewView.swift
//  Task2
//
//  Created by student on 8/2/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class NewView: UIView, UIGestureRecognizerDelegate, ViewControllerDelegate{
    
  //  @IBOutlet weak var VC : ViewController!
  //  var VC: ViewController! = ViewController()
//    var VC = ViewController()
   
    var currentView = UIView()
    static var defView = UIView()
    static var topView = UIView()
    var customView: UIView = defView
    var rotateDegree = false
    
    override init(frame: CGRect){
       super.init(frame: frame)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.addGestureRecognizer(tap)
        let move = UIPanGestureRecognizer(target: self, action: #selector(self.handleMove))
        self.addGestureRecognizer(move)
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(self.handleRotate))
        self.addGestureRecognizer(rotate)
        let scale = UIPinchGestureRecognizer(target: self, action: #selector(self.handleScale))
        self.addGestureRecognizer(scale)
 //       VC.delegate = self


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
        
    /*   while i > 0 {
            var newView =  NewView(frame: CGRect(x: indent, y: indent, width: width, height: height))
            newView.backgroundColor = .random
            currentView.addSubview(newView)
            currentView = newView
            indent = 10
            i = i - 1
        } */

        while i > 0 {
            //var newView =  NewView(frame: CGRect(x: indent, y: indent, width: width, height: height))
            var newView =  NewView()
            newView.backgroundColor = .random
            currentView.addSubview(newView)
            
            newView.translatesAutoresizingMaskIntoConstraints = false
            newView.topAnchor.constraint(equalTo: currentView.topAnchor, constant: CGFloat(indent)).isActive = true
            newView.leftAnchor.constraint(equalTo: currentView.leftAnchor, constant: CGFloat(indent)).isActive = true
            newView.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
            newView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
           indent = 10
            currentView = newView
            i = i - 1
        }
        NewView.topView = currentView
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
                subview.topAnchor.constraint(equalTo: (NewView.defView.topAnchor), constant: 0).isActive = true
                subview.leftAnchor.constraint(equalTo: (NewView.defView.leftAnchor), constant: 0).isActive = true
                NewView.defView.addSubview(subview)
            }
        } else {
            for subview in self.subviews{
                subview.topAnchor.constraint(equalTo: (superview?.topAnchor)!, constant: 10).isActive = true
                subview.leftAnchor.constraint(equalTo: (superview?.leftAnchor)!, constant: 10).isActive = true
                tempView?.addSubview(subview)
            }
        }
       /* let rotationTransform = CATransform3DRotate(self.layer.transform, CGFloat.pi, 3, 0, 0)
        
        UIView.animate(withDuration: 0.5) {
            self.layer.transform = rotationTransform
        }*/
        //self.rotate360Degrees()
        self.removeFromSuperview()
    }
    
    /*@objc func handleTap(sender: UIGestureRecognizer) {
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
    }*/
    
    @objc func handleMove(recognizer: UIPanGestureRecognizer){
            //self.transform = CGAffineTransform(rotationAngle: 180)
        
        let tempView = self.superview
        let movedView = self
        if superview == NewView.defView {
            for subview in self.subviews{
                subview.topAnchor.constraint(equalTo: (NewView.defView.topAnchor), constant: 0).isActive = true
                subview.leftAnchor.constraint(equalTo: (NewView.defView.leftAnchor), constant: 0).isActive = true
                NewView.defView.addSubview(subview)
            }
        } else {
        var indent = 10
            for subview in self.subviews{
                self.superview?.addSubview(subview)
                subview.topAnchor.constraint(equalTo: (self.superview?.topAnchor)!, constant: CGFloat(indent)).isActive = true
                subview.leftAnchor.constraint(equalTo: (self.superview?.leftAnchor)!, constant: CGFloat(indent)).isActive = true
                indent = indent + 10
            }
        }
//        for subview in NewView.defView.subviews{
//            if movedView == subview{
//                movedView.removeFromSuperview()
//                NewView.defView.addSubview(movedView)
//                movedView.center = NewView.defView.center
//            }
//        }
        if rotateDegree == false  {
            self.superview?.bringSubview(toFront: self)
            let translation = recognizer.translation(in: self)
            if let view = recognizer.view {
                view.center = CGPoint(x:view.center.x + translation.x,
                                      y:view.center.y + translation.y)
            }
            recognizer.setTranslation(CGPoint.zero, in: self)
          //  NewView.topView.addSubview(self)
        } else {
            self.superview?.bringSubview(toFront: self)
            let translation = recognizer.translation(in: self)
            if let view = recognizer.view {
                view.center = CGPoint(x:view.center.x + translation.x - translation.y/8,
                                      y:view.center.y + translation.y - translation.x/8)
            }
            recognizer.setTranslation(CGPoint.zero, in: self)
        }
    }
    
    @objc func handleRotate(recognizer: UIRotationGestureRecognizer){
        guard recognizer.view != nil else { return }
        
        if recognizer.state == .began || recognizer.state == .changed {
            recognizer.view?.transform = recognizer.view!.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
        rotateDegree = true
    }
    
    @objc func handleScale(recognizer sender: UIPinchGestureRecognizer){
        if sender.state == .began || sender.state == .changed {
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1.0
        }
    }
    
    
    func accessToText(count: Double)-> Double {
        return count
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

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = .infinity
        
        if let delegate: CAAnimationDelegate = completionDelegate as! CAAnimationDelegate? {
            rotateAnimation.delegate = delegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
