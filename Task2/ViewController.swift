//
//  ViewController.swift
//  Task2
//
//  Created by student on 8/2/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    var newView = NewView()
    var tap: UITapGestureRecognizer?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mainView: UIView!
    
    @IBAction func tapScreen(_ sender: Any) {
    //newView.deleteView()
        showMoreActions(touch: tap!)
        print("tapped")
    }

    override func viewDidLoad() {
        tap = UITapGestureRecognizer(target: self, action: "showMoreActions:")
        tap?.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap!)
    }
    
    func showMoreActions(touch: UITapGestureRecognizer) {
        
        let touchPoint = touch.location(in: self.view)
        print(touchPoint)
        newView.deleteView(coordinate: touchPoint)
        
    }
    
    @IBAction func tapGenerateButton(_ sender: Any) {
        view.endEditing(true)
            var amountOfView = Double(textField.text!)
            //Clear screen
            for subview in mainView.subviews as [UIView]   {
                subview.removeFromSuperview()
            }
        newView.createNewView(count: amountOfView!, mainView: mainView)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       view.endEditing(true)
        
    }
}



