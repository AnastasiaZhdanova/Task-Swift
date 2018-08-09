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
    
    var loadingData = [AppsViews]()
    
    struct AppsViews: Codable {
        let width: CGFloat
        let height: CGFloat
        let x: CGFloat
        let y: CGFloat
        let color: [CGFloat]
    }
    
    @IBOutlet weak private var textField: UITextField!
    @IBOutlet weak private var mainView: UIView!

     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Load.plist")
 //   let dataPath = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first?.appendingPathComponent("Load.plist")
    
    var delegate: ViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapGenerateButton(_ sender: Any) {
        
        if (textField.text?.characters.count)! <= 2{
        
        if (isСonform(to: textField.text!)) == true {
            //Clear screen
            for subview in mainView.subviews as [UIView]   {
                subview.removeFromSuperview()
            }
             view.endEditing(true)
            
           newView.createNewView(count: Double(textField.text!)!, mainView:mainView)

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
                "There must be only integer numbers!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            }
        } else {
            let alertController = UIAlertController(title: "Warning", message:
                "MAX Value is 99", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        saveApp()
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
        let regExptest = NSPredicate(format: "SELF MATCHES %@", "[0-9]*")
        return regExptest.evaluate(with: value)
    }
    
    func saveApp(){
     for subview in NewView.defView.subviews{
        
      let color = subview.backgroundColor?.cgColor
        let viewColor = color?.components
        print(viewColor)
        
        let saveView = AppsViews(width: subview.frame.width, height: subview.frame.height, x: subview.center.x, y: subview.center.y, color: viewColor! )
        
        let encoder =  PropertyListEncoder()
        do{
            let data =  try encoder.encode(loadingData)
            try data.write(to: dataFilePath!)
            print(data)
        } catch{
            print("Error encoding data \(error)")
        }
      }
    }
}

