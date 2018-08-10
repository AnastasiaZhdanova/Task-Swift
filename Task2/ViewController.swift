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

     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Load.json")

    
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
        var saveView = newView.customView
        var xxxView = UIView()
        for subview in saveView.subviews{
            xxxView = subview
        }
        for subview in (xxxView.subviews){
          let color = subview.backgroundColor?.cgColor
            let viewColor = color?.components
            print(viewColor)
        var saveView = AppsViews(width: subview.frame.width, height: subview.frame.height, x: subview.center.x, y: subview.center.y, color: viewColor! )
            loadingData.append(saveView)
            let encoder =  PropertyListEncoder()
            SaveData.store(loadingData, to: .documents, as: "Load.json")
            xxxView = subview
//        do{
//            let data =  try encoder.encode(loadingData)
//            try data.write(to: dataFilePath!)
//            print(data)
//        } catch{
//            print("Error encoding data \(error)")
//        }
      }
                    print(loadingData.count)
    }
    
    func loadApp(){
//        if let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do{
//               loadingData = try decoder.decode([AppsViews].self, from: data)
//            } catch {
//           print("Error decoding data \(error)")
//           }
//            print(loadingData)
////            var viewProperty = AppsViews.self
////           newView.currentView.frame.width = viewProperty.width
//         }
        let messagesFromDisk = SaveData.retrieve("Load.json", from: .documents, as: [AppsViews].self)
        loadingData = messagesFromDisk
        print(loadingData.count)

            
        }
    }


