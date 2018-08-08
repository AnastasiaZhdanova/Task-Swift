//
//  ViewController.swift
//  Task2
//
//  Created by student on 8/2/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate{
    func accessToText(count: Double) -> Double
//    func accesToView()
}


class ViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

  var newView = NewView()
    
    @IBOutlet weak private var textField: UITextField!
    @IBOutlet weak private var mainView: UIView!
    
    var delegate: ViewControllerDelegate?
    //var variable: Double =
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    @IBAction func tapGenerateButton(_ sender: Any) {
        if (isСonform(to: textField.text!)) == true {
            //Clear screen
            for subview in mainView.subviews as [UIView]   {
                subview.removeFromSuperview()
            }
             view.endEditing(true)
            newView.createNewView(count: Double(textField.text!)!, mainView:mainView)
//
//            let text = textField.text
//
//            if let doubleCount = Double(text!) {
//                let count = delegate?.accessToText(count: doubleCount)
//
//                newView.createNewView(count: count!, mainView: mainView)
//            }

            
        } else
        {
            let alertController = UIAlertController(title: "Warning", message:
                "There must be only numbers!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.accessToText(count: Double(textField.text!)!)
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       view.endEditing(true)
        
    }
    
    public func isСonform(to value: String) -> Bool {
        let regExptest = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
        return regExptest.evaluate(with: value)
    }
    
}



