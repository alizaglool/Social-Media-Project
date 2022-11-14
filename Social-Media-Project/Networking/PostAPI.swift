//
//  PostAPI.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 11/09/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostAPI: API {
    
    static func getPostUsers(page: Int, tags: String?, complition: @escaping ([Post],Int) -> () ){
        
        var postURl = "\(baseURL)/post"
        if var myTag = tags {
            myTag = myTag.trimmingCharacters(in: .whitespaces)
            postURl = "\(baseURL)/tag/\(myTag)/post"
        }
        
        let pramers = [
            "page": "\(page)",
            "limit": "5"
        ]
       
        AF.request(postURl, parameters: pramers, encoder: URLEncodedFormParameterEncoder.default , headers: headers).responseJSON { response in
            let josnData = JSON(response.value)
            let data = josnData["data"]
            let total = josnData["total"].intValue
            let decoder = JSONDecoder()
            do {
                let posts = try decoder.decode([Post].self, from: data.rawData())
                complition(posts, total)
            }catch let error {
                print(error)
            }
            
        }
    }
    
    static func addNewPost(text: String, ownerId: String, complitionHander: @escaping () -> () ) {
        
        let url = "\(baseURL)/post/create"
        let pramers = [
            "text": text,
            "owner": ownerId
        ]
        AF.request(url, method: .post, parameters: pramers, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                    complitionHander()
            case .failure(let error):
                print(error)
            }
           
        }
    }
    
    static func getCommentsOfPost(id: String, complitionHander: @escaping ([Comment]) -> ()){
        
        let commentURL = "\(baseURL)/post/\(id)/comment"
        AF.request(commentURL, headers: headers).responseJSON { response in
            let josnData = JSON(response.value)
            let data = josnData["data"]
            let decoder = JSONDecoder()
            do {
                let comments = try decoder.decode([Comment].self, from: data.rawData())
                complitionHander(comments)
            }catch let error {
                print(error)
            }
        

        }
    }
    static func creatCommenttoPost(postId: String, ownerId: String, message: String, complitionHander: @escaping () -> () ) {
        
        let url = "\(baseURL)/comment/create"
        let pramers = [
            "post": postId,
            "owner": ownerId,
            "message": message
        ]
        AF.request(url, method: .post, parameters: pramers, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                    complitionHander()
            case .failure(let error):
                print(error)
            }
           
        }
    }
    
//    static func getAllTags(complition: @escaping ([String]) -> () ){
//        
//        let postURl = "\(baseURL)/tag"
//       
//        AF.request(postURl, headers: headers).responseJSON { response in
//            
//            let josnData = JSON(response.value)
//            let data = josnData["data"]
//            print(data)
//            let decoder = JSONDecoder()
//            do {
//                let tagss = try decoder.decode([String].self, from: data.rawData())
//                print(tagss)
////                complition(tagss)
//            }catch let error {
//                print(error.localizedDescription)
//            }
//            
//        }
//    }
//    static func testCommenttoPost(url: EndPoint ,pramers: [String: String],method: HTTPMethod, complitionHander: @escaping () -> () ) {
//        
//        let URL = "\(baseURL)/\(url.rawValue)"
//        
//        AF.request(URL, method: method , parameters: pramers, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
//            switch response.result {
//            case .success:
//                    complitionHander()
//            case .failure(let error):
//                print(error)
//            }
//           
//        }
//    }
}
//Zaghloul24172405ali@
