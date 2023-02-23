//
//  GenericAPIStuff.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 22/02/23.
//

import Foundation

class GenericAPIInfo{
    
    enum MethodType: String{
       case GET
       case POST
       case PUT
       case DELETE
        
        var stringValue: String{
            switch self{
            case .GET: return "GET"
            case .PUT: return "PUT"
            case .DELETE: return "DELETE"
            case .POST: return "POST"
            }
        }
    }
    
    
    
    class func taskInteractWithAPI<ResponseType: Decodable>(methodType: MethodType,url:URL, requestBody: String ,responseType: ResponseType.Type ,completionHandler: @escaping (ResponseType?, Error?) -> Void){
        
        switch methodType{
        case .GET:
            let task = URLSession.shared.dataTask(with: url, completionHandler: {(data,response,error) in
                guard let data = data else{
                    print("GET Request failed in function: GenericAPIInfo.taskGETRequestOperation ")
                    DispatchQueue.main.async {
                        completionHandler(nil,error)
                    }
                    return
                }
                
                let decoder = JSONDecoder()
                
                do{
                    let responseObject = try! decoder.decode(ResponseType.self, from: data)
                    
                    DispatchQueue.main.async {
                        completionHandler(responseObject, nil)
                    }
                    
                }
            })
            task.resume()
            return
            
        case .POST:
            var request = URLRequest(url: url)
            request.httpMethod = MethodType.POST.stringValue
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            do{
                request.httpBody = requestBody.data(using: .utf8)
                
                let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                    guard let data = data else {
                        DispatchQueue.main.async {
                            completionHandler(nil, error)
                            print("Failed to send the sessionID request package")
                        }
                        return
                    }
                    
                    do{
                        let range = 5..<data.count
                      let newData = data.subdata(in: range)
                        
                        let responseBody = try JSONDecoder().decode(ResponseType.self, from: newData)
                        DispatchQueue.main.async {
                            completionHandler(responseBody, nil)
                        }
                    }catch{
                        DispatchQueue.main.async {
                            completionHandler(nil, error)
                        }
                       
                    }
                })
                task.resume()
            }
            return
        case .PUT: return
        case .DELETE: return
            //        var request = URLRequest(url: url)
            //        request.httpMethod = "DELETE"
            //
            //        let body = LogoutRequest(sessionId: Auth.sessionId)
            //        request.httpBody = try! JSONEncoder().encode(body)
            //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //
            //        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            //
            //            Auth.requestToken = ""
            //            Auth.sessionId = ""
            //            completionHandler()
            //
            //        })
            //
            //        task.resume()
        }
        
    }
}
