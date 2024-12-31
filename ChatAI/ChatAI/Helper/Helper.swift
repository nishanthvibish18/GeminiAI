//
//  Helper.swift
//  ChatAI
//
//  Created by Nishanth on 30/07/24.
//

import Foundation


struct AppKey{
    
    static var apiKey: String{
        
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist") else{return ""}
        
            let plist =  NSDictionary(contentsOfFile: filePath)
        guard let aiAPIKey = plist?.object(forKey: "API-KEY") as? String else{
                return ""
            }
            
            if aiAPIKey.starts(with: "-"){
                return ""
            }
            
            return aiAPIKey

    }
}
