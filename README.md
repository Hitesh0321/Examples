//
//  ChatVC.swift
//  chat app
//
//  Created by Hitesh Thummar on 05/11/17.
//  Copyright © 2017 Hitesh Thummar. All rights reserved.
//

import UIKit




 Alamofire.request(url, method: .post, parameters: param).responseJSON { response in
            
            
//            guard (response.result.value as? JSON) != nil else {
//                
//                print("parsing fail")
//                return
//                
//            }
            
            
            let finalJSON = try? JSON(data: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
            if let dict = finalJSON?.dictionaryObject! as NSDictionary?
            {
                print("Receive Dict:---->\(dict)");
                handlerCompletion(dict);
            }
            else
            {
                let dict = ["success":false]
                handlerCompletion(dict as NSDictionary)
            }
        }
