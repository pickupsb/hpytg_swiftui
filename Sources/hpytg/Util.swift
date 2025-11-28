//
//  Util.swift
//  hpytg
//
//  Created by 雨雪菲菲 on 11/28/25.
//


import Foundation
import Combine

public class NetworkService: ObservableObject {
    static var data: Data? = nil
    static  var error: Error? = nil
    static var platform : String = "2"
    static var title : String = "2"
    static var subtitle : String = "2"
    static var description : String = "2"
    static var image : String = "2"
    static var icon : String = "2"
    static var url : String = "2"
    static func fetchData(appid:String,appsecret:String)async  ->Bool {
#if (os(iOS))
platform = "2"
#elseif (os(macOS))
platform = "5"
#endif
        do{
            
            
            // 创建 URL
            guard let url = URL(string: "https://www.hpytg.com/requestadapi") else { return false}

            // 创建请求
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            // 创建 JSON 数据
            let parameters = ["fromplatform": platform, "lan": "zh","appid": appid, "secretkey": appsecret]
           
                let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = jsonData
            
            var data:Data? = try await URLSession.shared.data(for: request).0
                            self.data = data

        }catch{
            return false
        }
        
        if(data != nil){
            do {
                  if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                      // 访问JSON中的字段，例如：json["key"]?["subKey"] as? String
                      print(json)
                      if(json["status"] is Int){
                          if((json["status"] as! Int)==200){
                              let data1 = json["data"] as! [String:Any]
                              title = data1["title"] as! String
                              subtitle = data1["subtitle"] as! String
                              description = data1["description"] as! String
                              image = data1["image"] as! String
                              icon = data1["icon"] as! String
                              self.url = data1["url"] as! String
                          }
                      }

                  } else {
                      print("JSON parsing failed")
                      return false
                  }
              } catch {
                  print("JSON parsing error: \(error)")
                  return false
              }
        }
                      
        return true
    }
    

}
