//
//  Initializer.swift
//  cp_Example
//
//  Created by Macintosh on 16/05/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON



public final class InitializerCl {
    
    // Properties
    public var textEntry: String?
    private let NM = NetworkManager.shared
    public static let shared = InitializerCl()
    
    
    //    MARK:- Get Tags for entered Text
    public func getTgs()-> Promise<[JSON]>{
        return self.NM.GetTags(for: self.textEntry!)
    }
    
    
    //    MARK:- Get Meal Id for selected Category
    public func getMealId(for cat: MealType) ->  Promise<Int> {
        return self.NM.GetMealID(category: cat, rawText: self.textEntry!)
    }
    
    //    MARK:- Get Log Id
    public func GetLogId(for MealID: String,date:Date)-> Promise<Int> {
        return self.NM.getLogID(for:MealID ,rawText:self.textEntry!,user_ID:Helper.shared.uuid,date:date)
    }
    
    
}
