//
//  ViewController.swift
//  cp
//
//  Created by upworktinesh on 05/16/2022.
//  Copyright (c) 2022 upworktinesh. All rights reserved.
//

import UIKit
import cp
import SwiftyJSON

class ViewController: UIViewController {

    //    MARK:- Outlets
    @IBOutlet var EnteredText: UILabel!
    @IBOutlet var MealId: UILabel!
    @IBOutlet var tagsList: UILabel!
    @IBOutlet var logId: UILabel!
    @IBOutlet var TF: UITextField!
    
    //    MARK:-  Properties
    let meals           : [MealType]    = [.Breakfast,.Lunch,.Snacks,.Dinner]
    var selectedMeal    : MealType      = .Lunch
    var tags            : [Tags]        = [Tags]()
    var cp              : InitializerCl = InitializerCl()
    var tagJson         : [JSON]        = [JSON.null]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.callAPI()
    }
    
    
    @IBAction func processBtn(_ sender: Any) {
        self.TF.text = "mango"
        self.EnteredText.text = self.TF.text
        self.TF.placeholder = "Enter your diet and press send button"
        cp.textEntry = self.EnteredText.text
        getTags()
//        getMealID()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func getTags(){
        
        cp.APIManager.GetTags(for: self.TF.text!) { [self] success, error in
            guard let json = success else {
                print(error)
                return
            }
            print("Response json:",json)
            gettagss(json: json)
        }
//        let result = cp.getTgs()
//        print(result.0,result.1)
//        let resulst = cp.getTgs().then { result in
//            self.gettagss(json: result)
//        }.recover { error in
//            print(error)
//        }
//        print("Get Tags response :",resulst)
    }
    
    
//    func getLogID(id:String){
//        self.MealId.text = id
//        let result = cp.GetLogId(for: id, date: Date()).then { id in
////                print("log id is :",id)
//            self.logId.text = "\(id)"
//        }.recover { error in
//            print(error)
//        }
//    }
    
    
//    func getMealID(){
//        let res = cp.getMealId(for: self.selectedMeal).then { id -> () in
//            self.getLogID(id: "\(id)")
//        }.recover { error in
//            print(error)
//        }
//    }
    
    
    func gettagss(json:[JSON]){
        var tg  = ""
        json.forEach { j in
            let tag = j["Food"][0]
            tg += "\(j["Quant"][0]) \(j["Food"][0]),"
        }
        self.tagsList.text = tg
        print(json)
    }
    

}


