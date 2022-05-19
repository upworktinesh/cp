//
//  NetworkManager..swift
//  cp_Example
//
//  Created by Macintosh on 16/05/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

internal class NetworkManager {
    static let shared = NetworkManager()
    /// `BASE URL`
    private let BASE_URL = "https://fuzzy-wuzzy.csail.mit.edu/Coco/coco/api/v1.0/"
    /// `Get Tags` endpoint
    private let getTags = "get_tags?raw_text="
    /// `Get Meal Id` endpoint
    private let NewMeal = "new_meal?"
    /// ``
    
    //    MARK:- Get Tags API
    func GetTags(for RawText: String)-> Promise<[JSON]> {
        var urlWithParameters = self.BASE_URL+self.getTags+RawText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return Promise(resolvers: { (fulfill, reject) in
            // get tags
            var foodList : [JSON] = [JSON.null]
            Alamofire.request(urlWithParameters, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
                .validate()
                .responseJSON(completionHandler: { response in
                    if response.result.isSuccess {
                        foodList = JSON(response.result.value!).array!
                        fulfill(foodList)
                        return
                    } else {
                        reject("response failure get tags" as! Error)
                        print(response.result)
                        return
                    }
            })
        })
        
    }
    
    //    MARK:- Get MealID API
    func GetMealID(category:MealType,rawText:String) -> Promise<Int> {
        let dateString :String = Helper.shared.getDate(date: Date()).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let urlWithParameter  = self.BASE_URL+self.NewMeal+"user_id="+Helper.shared.uuid + "&date=" + dateString + "&category=" + category.rawValue
        return Promise(resolvers: { (fulfill, reject) in
            
            // get new meal ID
            Alamofire.request(urlWithParameter, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
                .validate()
                .responseJSON(completionHandler: { response in
                if response.result.isSuccess {
                    print("successfully added new meal")
                    let newID = JSON(response.result.value!)["mealID"].int!
                    print(newID)
                    fulfill(newID)
                    self.getLogID(for: "\(newID)", rawText: rawText, user_ID: Helper.shared.uuid, date:  Date())
                    return
                } else {
                    reject("unable to add new meal" as! Error)
                    return
                }
            })
        })
        
    }
    
    //    MARK:- Get Log ID
    func getLogID(for mealID: String,rawText:String,user_ID:String?,date:Date) -> Promise<Int> {
        
        let date : String = Helper.shared.getDate(date: date).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let queries =  "\(mealID)&raw_text=\(rawText)&user_id=\(user_ID!)&date=\(date)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        var urlWithParameters = self.BASE_URL + "new_log?meal_id=" + queries!
//        urlWithParameters = urlWithParameters
        print("Get Log ID urlWithParameters : ",urlWithParameters)
        return Promise(resolvers: { (fulfill, reject) in
            // get new meal ID
            Alamofire.request(urlWithParameters, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
                .validate()
                .responseJSON(completionHandler: { response in
                if response.result.isSuccess {
                    print("successfully added new log")
                    let logID = JSON(response.result.value!)["logID"].int!
                    print(logID)
                    fulfill(logID)
                } else {
                    reject("couldn't add new log" as! Error)
                    return
                }
            })
        })
    }
    
    
    
    
    
    
}


class Helper {
    static let shared = Helper()
    public var uuid = UUID().uuidString
    func getDate(date: Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let year = calendar.component(.year, from: date)
        let dateString = String(month)+"_"+String(day)+"_"+String(year)+"_"+String(hour)+"_"+String(minutes)
        return dateString
    }
}
