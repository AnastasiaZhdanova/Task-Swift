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

    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Load.json")

    
    var delegate: ViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if SaveData.fileExists("Load.json", in: .documents) == true
        {
            loadApp()
        }
    }

    
    @IBAction func tapGenerateButton(_ sender: Any) {
        
        if (textField.text?.characters.count)! <= 3 && (textField.text?.characters.count)! > 0{
        
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
                "You must enter value. MAX is 999", preferredStyle: UIAlertControllerStyle.alert)
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
        let regExptest = NSPredicate(format: "SELF MATCHES %@", "[0-9]*")
        return regExptest.evaluate(with: value)
    }
    
    func saveApp(){
     SaveData.clear( .documents)
        var saveView = NewView.defView
        var xxxView = [UIView]()
        var i = 0
        for subview in NewView.defView.subviews{
            let color = subview.backgroundColor?.cgColor
            let viewColor = color?.components
            print(viewColor)
            var saveView = AppsViews(width: subview.frame.width, height: subview.frame.height, x: subview.center.x, y: subview.center.y, color: viewColor! )
            loadingData.append(saveView)
            if subview.subviews.count > 0 {
                xxxView.append(subview)
            }
        }
        print("xxxView \(xxxView.count)")
        while i < xxxView.count{
            for subview in (xxxView[i].subviews){
              let color = subview.backgroundColor?.cgColor
                let viewColor = color?.components
                print(viewColor)
                var saveView = AppsViews(width: subview.frame.width, height: subview.frame.height, x: subview.center.x, y: subview.center.y, color: viewColor! )
                loadingData.append(saveView)
                xxxView[i] = subview
                i = i + 1
                }
        }
//        do{
//            let data =  try encoder.encode(loadingData)
//            try data.write(to: dataFilePath!)
//            print(data)
//        } catch{
//            print("Error encoding data \(error)")
//        }
            let encoder =  PropertyListEncoder()
            SaveData.store(loadingData, to: .documents, as: "Load.json")
            print("Saving \(loadingData.count)")
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
        print("Loading \(loadingData.count)")
        for i in 0...loadingData.count-1 {
            var createdView = NewView()
            createdView.frame.size.width = loadingData[i].width
            createdView.frame.size.height = loadingData[i].height
            createdView.center.x = loadingData[i].x
            createdView.center.y = loadingData[i].y
            let swiftColor = UIColor(red: loadingData[i].color[0], green: loadingData[i].color[1], blue: loadingData[i].color[2], alpha: loadingData[i].color[3])
            createdView.layer.cornerRadius = 6
            createdView.layer.shadowOffset = CGSize(width: 2, height: 2)
            createdView.layer.shadowRadius = 3
            createdView.layer.shadowOpacity = 0.25
            createdView.isUserInteractionEnabled = true
            createdView.backgroundColor = swiftColor
            mainView.addSubview(createdView)
        }
        
        }
    }


