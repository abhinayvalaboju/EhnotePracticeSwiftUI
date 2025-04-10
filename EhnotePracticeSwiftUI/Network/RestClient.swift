//
//  RestClient.swift
//  EHNOTE Doc
//
//  Created by Appdest Technologies on 02/04/19.
//  Copyright © 2019 Appdest Technologies. All rights reserved.
//

import Foundation
import Alamofire

class RestClient {
    
    static func headers() -> [String: String] {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
    
//    class func headers() -> HTTPHeaders {
//        
//        var authorizationToken = ""
//        if let auth = UserDefaults.standard.value(forKey: "authorizationToken") as? String {
//            authorizationToken = auth
//        }
////        let headers: HTTPHeaders = [
////            "Content-Type": "application/json",
////            "Accept": "application/json",
////            "Authorization": authorizationToken
////        ]
//        return headers()
//    }
    class func requestPOSTURLObject<T: Decodable>(
            _ strURL: String,
            params: [String: Any]?,
            headers: HTTPHeaders? = nil,
            responseType: T.Type,
            success: @escaping (T) -> Void,
            failure: @escaping (Error) -> Void
        ) {
            Constants.printData(data: strURL)
            Constants.printData(data: params)

            AF.request(strURL,
                       method: .post,
                       parameters: params,
                       encoding: JSONEncoding.default,
//                       headers: HTTPHeaders(RestClient.headers()))
                       headers: headers ?? HTTPHeaders(RestClient.headers()))
                .validate()
                .responseDecodable(of: responseType) { response in
                    Constants.printData(data: response)

                    switch response.result {
                    case .success(let data):
                        success(data)
                    case .failure(let error):
                        failure(error)
                    }
                }
        }
}

//class RestClient {
//    
//    // Request GET without parameters
//    class func requestGETURL(_ strURL: String, success:@escaping (DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void) {
//        
//        Constants.printData(data: strURL)
//        AF.request(strURL, headers: APIManager.headers()).responseJSON { (responseObject) -> Void in
//            
//            Constants.printData(data: responseObject)
//            
//            if responseObject.result.isSuccess {
//                success(responseObject)
//            }
//            if responseObject.result.isFailure {
//                if let error: Error = responseObject.result.error {
//                    failure(error)
//                }
//                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//            }
//        }
//    }
//    
//    
//    // Request GET with parameters
//    class func requestGETURL(_ strURL: String,
//                             params: [String: Any]?,
//                             success:@escaping (DataResponse<Any>) -> Void,
//                             failure:@escaping (Error) -> Void) {
//        
//        Constants.printData(data: strURL)
//        
//        AF.request(strURL,
//                          method: .get,
//                          parameters: params,
//                          encoding: URLEncoding.default,
//                          headers: APIManager.headers()).responseJSON { (responseObject) -> Void in
//            
//            Constants.printData(data: responseObject)
//            
//            if responseObject.result.isSuccess {
//                success(responseObject)
//            }
//            if responseObject.result.isFailure {
//                if let error: Error = responseObject.result.error {
//                    failure(error)
//                }
//                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//            }
//        }
//    }
//    
//    // This is for parameters type like [String: String] in Get Query String
//    class func requestGetNewQueryStringParameters(_ strURL: String, params: [String: String], success: @escaping(DataResponse<Any>) -> Void, failure: @escaping(Error) -> Void) {
//        Constants.printData(data: strURL)
//        
//        var urlComps = NSURLComponents(string: strURL)
//        urlComps?.queryItems = params.map({ URLQueryItem(name: $0, value: $1) })
//        
//        let URL = urlComps?.url
//        print(URL)
//        
//        AF.request(URL ?? NSURL() as URL, method: .get, headers: APIManager.headers()).responseJSON { (responseObject) -> Void in
//            
//            Constants.printData(data: responseObject)
//            
//            if responseObject.result.isSuccess {
//                success(responseObject)
//            }
//            if responseObject.result.isFailure {
//                if let error: Error = responseObject.result.error {
//                    failure(error)
//                }
//            }
//        }
//        
//    }
//    
//    // This is for parameters tuype like [String: Any] in Get Query String
//    class func requestGetNewQueryStringParameters2(_ strURL: String, params: [String: Any], success: @escaping(DataResponse<Any>) -> Void, failure: @escaping(Error) -> Void) {
//        Constants.printData(data: strURL)
//        
//        let urlComps = NSURLComponents(string: strURL)
//        urlComps?.queryItems = params.map({ URLQueryItem(name: $0, value: $1 as? String) })
//        
//        let URL = urlComps?.url
//        print(URL)
//        
//        AF.request(URL ?? NSURL() as URL, method: .get, headers: APIManager.headers()).responseJSON { (responseObject) -> Void in
//            
//            Constants.printData(data: responseObject)
//            
//            if responseObject.result.isSuccess {
//                success(responseObject)
//            }
//            if responseObject.result.isFailure {
//                if let error: Error = responseObject.result.error {
//                    failure(error)
//                }
//            }
//        }
//        
//    }
//    
//    
//    class func requestGETQueryStringURL(_ strURL: String, appID: Int?, success:@escaping (DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void) {
//        
//        Constants.printData(data: strURL)
//        
//        let queryDictionary = [ "Appointmentid": String(appID ?? 0),
//                                "PageSize": "50",
//                                "PageNumber": "1",
//                                "Type": String(true)]
//        var components = NSURLComponents(string: strURL)!
//        components.queryItems = queryDictionary.map {
//             URLQueryItem(name: $0, value: $1)
//        }
//        let URL = components.url
//        Constants.printData(data: URL)
//        
//        AF.request(URL ?? NSURL() as URL, headers: APIManager.headers()).responseJSON { (responseObject) -> Void in
//            
//            Constants.printData(data: responseObject)
//            
//            if responseObject.result.isSuccess {
//                success(responseObject)
//            }
//            if responseObject.result.isFailure {
//                if let error: Error = responseObject.result.error {
//                    failure(error)
//                }
//            }
//        }
//    }
//    
//    // This function is for string object
//    class func requestPOSTURL(_ strURL: String,
//                              params: [String: Any]?,
//                              success:@escaping (DataResponse<Any>) -> Void,
//                              failure:@escaping (Error) -> Void) {
//        
//        Constants.printData(data: strURL)
//        
//        let stringParameter: String = APIManager.convertDictionaryParameterToStringParameter(params ?? [:])
//        Constants.printData(data: stringParameter)
//        AF.request(strURL,
//                          method: .post,
//                          parameters: [:],
//                          encoding: stringParameter,
//                          headers: APIManager.headers()).responseJSON { (responseObject) -> Void in
//            
//            Constants.printData(data: responseObject)
//                      
//            if responseObject.result.isSuccess {
//                 success(responseObject)
//            }
//            
//            if responseObject.result.isFailure {
//               if let error: Error = responseObject.result.error {
//                  failure(error)
//               }
//                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//           }
//        }
//    }
//    
//    // This function is for olny object
//    class func requestPOSTURLObject(_ strURL: String,
//                              params: [String: Any]?,
//                              success:@escaping (DataResponse<Any>) -> Void,
//                              failure:@escaping (Error) -> Void) {
//        
//        Constants.printData(data: strURL)
//        Constants.printData(data: params)
//        AF.request(strURL,
//                          method: .post,
//                          parameters: params,
//                          encoding: JSONEncoding.default,
//                          headers: APIManager.headers()).responseJSON { (responseObject) -> Void in
//                            
//                            Constants.printData(data: responseObject)
//                            if responseObject.result.isSuccess {
//                                success(responseObject)
//                            }
//                            if responseObject.result.isFailure {
//                                if let error: Error = responseObject.result.error {
//                                    failure(error)
//                                }
//                                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//                            }
//        }
//    }
//        
//    
//    class func requestPUTURL(_ strURL: String,
//                             params: [String: Any]?,
//                             success:@escaping (DataResponse<Any>) -> Void,
//                             failure:@escaping (Error) -> Void) {
//        
//        Constants.printData(data: strURL)
//        AF.request(strURL,
//                          method: .put,
//                          parameters: params,
//                          encoding: JSONEncoding.default,
//                          headers: APIManager.headers()).responseJSON { (responseObject) -> Void in
//                            
//                            Constants.printData(data: responseObject)
//                            if responseObject.result.isSuccess {
//                                success(responseObject)
//                            }
//                            if responseObject.result.isFailure {
//                                if let error: Error = responseObject.result.error {
//                                    failure(error)
//                                }
//                                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//                            }
//        }
//    }
//    
//    class func requestPOSTURLwithHeaders(_ strURL: String,
//                                         headers: HTTPHeaders?,
//                                         params: [String: Any]?,
//                                         success:@escaping (DataResponse<Any>) -> Void,
//                                         failure:@escaping (Error) -> Void) {
//        
//        let requestHeaders: HTTPHeaders = ["Accept": "application/json"]
//        var headerParams: HTTPHeaders?
//        if let headers: HTTPHeaders = headers {
//            headerParams = requestHeaders.merging(headers) { $1 }
//        }
//        Constants.printData(data: strURL)
//        AF.request(strURL,
//                          method: .post,
//                          parameters: params,
//                          encoding: JSONEncoding.default,
//                          headers: headerParams).responseJSON { (responseObject) -> Void in
//                            //            HUD.sharedInstance.stopHUD()
//                            Constants.printData(data: responseObject)
//                            if responseObject.result.isSuccess {
//                                success(responseObject)
//                            }
//                            if responseObject.result.isFailure {
//                                if let error: Error = responseObject.result.error {
//                                    failure(error)
//                                }
//                                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//                            }
//        }
//    }
//    
//    class func deleteRequest(_ strURL: String, success:@escaping (DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void) {
//        
//        Constants.printData(data: strURL)
//        AF.request(strURL,
//                          method: .delete,
//                          encoding: JSONEncoding.default,
//                          headers: APIManager.headers()).responseJSON { (responseObject) -> Void in
//                            
//                            Constants.printData(data: responseObject)
//                            if responseObject.result.isSuccess {
//                                success(responseObject)
//                            }
//                            if responseObject.result.isFailure {
//                                if let error: Error = responseObject.result.error {
//                                    failure(error)
//                                }
//                                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//                            }
//        }
//    }
//    
//    class func requestPOSTURLWithFormData(_ strURL: String,
//                                          params: [String: Any]?,
//                                          success:@escaping (DataResponse<Any>) -> Void,
//                                          failure:@escaping (Error) -> Void) {
//        
//        let requestHeaders: HTTPHeaders = ["Accept": "application/json",
//                                           "Content-Type": "x-www-form-urlencoded"]
//        
//        Constants.printData(data: strURL)
//        AF.request(strURL,
//                          method: .post,
//                          parameters: params,
//                          encoding: JSONEncoding.default,
//                          headers: requestHeaders).responseJSON { (responseObject) -> Void in
//                            
//                            Constants.printData(data: responseObject)
//                            if responseObject.result.isSuccess {
//                                success(responseObject)
//                            }
//                            if responseObject.result.isFailure {
//                                if let error: Error = responseObject.result.error {
//                                    failure(error)
//                                }
//                                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//                            }
//        }
//    }
//    
//    class func uploadMultipartFormDataWithModel(_ strURL: String,
//                                           params: [String: AnyObject]?,
//                                           imagesData: [String: Any]?,
//                                           success:@escaping (DataResponse<Any>) -> Void,
//                                           failure:@escaping (NSError) -> Void) {
//            
//            AF.upload(multipartFormData: { (multipartFormData) in
//                
//                if let imageData: Data = imagesData?["data"] as? Data {
//                    multipartFormData.append(imageData,
//                                             withName: "file2",
//                                             fileName: "profile.png",
//                                             mimeType: "image/png")
//                }
//                do {
//                    let jsonData: Data = try JSONSerialization.data(withJSONObject: params ?? [], options: .prettyPrinted)
//                    multipartFormData.append(jsonData, withName: "model")
//                    
//                } catch {
//                   print(error.localizedDescription)
//                }
//            }, to: strURL, method: .post, headers: APIManager.headers(), encodingCompletion: { (result) in
//                switch result {
//                case .success(let upload, _, _):
//                    upload.responseJSON(completionHandler: { (dataResponse) in
//                        if dataResponse.result.error != nil {
//                            if let error: Error = dataResponse.result.error {
//                                failure(error as NSError)
//                            }
//                          Constants.printData(data: dataResponse.result.error?.localizedDescription ?? "")
//                     
//                        } else {
//                            Constants.printData(data: dataResponse.result.value as Any)
//                            success(dataResponse)
//                        }
//                    })
//                case .failure(let encodingError):
//                    failure(encodingError as NSError)
//                    Constants.printData(data: encodingError)
//                    //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//                }
//            })
//        }
//    
//    /*class func uploadMultipartFormDataWithModel(_ strURL: String,
//                                       params: [String: AnyObject]?,
//                                       imagesData: [[String: Any]]?,
//                                       success:@escaping (DataResponse<Any>) -> Void,
//                                       failure:@escaping (NSError) -> Void) {
//        
//        AF.upload(multipartFormData: { (multipartFormData) in
//            
//            for index: Int in 0..<(imagesData?.count ?? 0) {
//                if let imageData: Data = imagesData?[index]["data"] as? Data {
//                    multipartFormData.append(imageData,
//                                             withName: "file1",
//                                             fileName: String(imagesData?[index]["name"] as? String ?? "") + ".png",
//                                             mimeType: "image/png" )
//                }
//            }
//            
//            do {
//                let jsonData: Data = try JSONSerialization.data(withJSONObject: params ?? [], options: .prettyPrinted)
//                multipartFormData.append(jsonData, withName: "model")
//                
//            } catch {
//               print(error.localizedDescription)
//            }
//        }, to: strURL, method: .post, headers: APIManager.headers(), encodingCompletion: { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.responseJSON(completionHandler: { (dataResponse) in
//                    if dataResponse.result.error != nil {
//                        if let error: Error = dataResponse.result.error {
//                            failure(error as NSError)
//                        }
//                      Constants.printData(data: dataResponse.result.error?.localizedDescription ?? "")
//                 
//                    } else {
//                        Constants.printData(data: dataResponse.result.value as Any)
//                        success(dataResponse)
//                    }
//                })
//            case .failure(let encodingError):
//                failure(encodingError as NSError)
//                Constants.printData(data: encodingError)
//                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//            }
//        })
//    }*/
//    
//    /*************** FOR SINGLE Video UPLOAD ****************/
//    class func uploadVideoMultipartFormData(_ strURL: String,
//                                       params: [String: Any]?,
//                                       imagesData: [String: Any]?,
//                                       success:@escaping (DataResponse<Any>) -> Void,
//                                       failure:@escaping (NSError) -> Void) {
//        AF.upload(multipartFormData: { (multipartFormData) in
//            
//            if let imageData: Data = imagesData?["data"] as? Data {
//                multipartFormData.append(imageData,
//                                         withName: "file",
//                                         fileName: String(Date().ticks)+".mp4",
//                                         mimeType: "video/mp4" )
//            }
//            
//              
//            
//            
//            for (key, value) in params ?? [:] {
//                multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
//            }
//            
//        }, to: strURL, method: .post, headers: APIManager.headers(), encodingCompletion: { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.responseJSON(completionHandler: { (dataResponse) in
//                    if dataResponse.result.error != nil {
//                        if let error: Error = dataResponse.result.error {
//                            failure(error as NSError)
//                        }
//                        Constants.printData(data: dataResponse.result.error?.localizedDescription ?? "")
//                        
//                    } else {
//                        /*** delete temp files Alamofire generated ***/
//                        let temporaryDirectoryPath = NSTemporaryDirectory()
//                        let dir = NSURL(fileURLWithPath: temporaryDirectoryPath, isDirectory: true)
//                            //.appendingPathComponent("com.alamofire.manager")
//                            .appendingPathComponent("multipart.form.data")
//                        do {
//                            try FileManager.default.removeItem(atPath: dir!.path)
//                        } catch {}
//                        Constants.printData(data: dataResponse.result.value as Any)
//                        success(dataResponse)
//                    }
//                })
//            case .failure(let encodingError):
//                failure(encodingError as NSError)
//                Constants.printData(data: encodingError)
//                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//            }
//        })
//    }
//    
//    /*************** FOR SINGLE IMAGES UPLOAD ****************/
//    class func uploadMultipartFormData(_ strURL: String,
//                                       params: [String: Any]?,
//                                       imagesData: [String: Any]?,
//                                       success:@escaping (DataResponse<Any>) -> Void,
//                                       failure:@escaping (NSError) -> Void) {
//        AF.upload(multipartFormData: { (multipartFormData) in
//            
//            if let imageData: Data = imagesData?["data"] as? Data {
//                multipartFormData.append(imageData,
//                                         withName: "file",
//                                         fileName: String(Date().ticks)+".png",
//                                         mimeType: "image/png" )
//            }
//            
//            for (key, value) in params ?? [:] {
//                multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
//            }
//            
//        }, to: strURL, method: .post, headers: APIManager.headers(), encodingCompletion: { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.responseJSON(completionHandler: { (dataResponse) in
//                    if dataResponse.result.error != nil {
//                        if let error: Error = dataResponse.result.error {
//                            failure(error as NSError)
//                        }
//                        Constants.printData(data: dataResponse.result.error?.localizedDescription ?? "")
//                        
//                    } else {
//                        /*** delete temp files Alamofire generated ***/
//                        let temporaryDirectoryPath = NSTemporaryDirectory()
//                        let dir = NSURL(fileURLWithPath: temporaryDirectoryPath, isDirectory: true)
//                            //.appendingPathComponent("com.alamofire.manager")
//                            .appendingPathComponent("multipart.form.data")
//                        do {
//                            try FileManager.default.removeItem(atPath: dir!.path)
//                        } catch {}
//                        Constants.printData(data: dataResponse.result.value as Any)
//                        success(dataResponse)
//                    }
//                })
//            case .failure(let encodingError):
//                failure(encodingError as NSError)
//                Constants.printData(data: encodingError)
//                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//            }
//        })
//    }
//    
//    /*************** FOR PDF UPLOAD ****************/
//    class func uploadPDFMultipartFormData(_ strURL: String,
//                                       params: [String: Any]?,
//                                       imagesData: [String: Any]?,
//                                       success:@escaping (DataResponse<Any>) -> Void,
//                                       failure:@escaping (NSError) -> Void) {
//        AF.upload(multipartFormData: { (multipartFormData) in
//            
//            if let imageData: Data = imagesData?["data"] as? Data {
//                multipartFormData.append(imageData,
//                                         withName: "file",
//                                         fileName: String(Date().ticks)+".pdf",
//                                         mimeType: "application/pdf" )
//            }
//            
//            for (key, value) in params ?? [:] {
//                multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
//            }
//            
//        }, to: strURL, method: .post, headers: APIManager.headers(), encodingCompletion: { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.responseJSON(completionHandler: { (dataResponse) in
//                    if dataResponse.result.error != nil {
//                        if let error: Error = dataResponse.result.error {
//                            failure(error as NSError)
//                        }
//                        Constants.printData(data: dataResponse.result.error?.localizedDescription ?? "")
//                        
//                    } else {
//                        /*** delete temp files Alamofire generated ***/
//                        let temporaryDirectoryPath = NSTemporaryDirectory()
//                        let dir = NSURL(fileURLWithPath: temporaryDirectoryPath, isDirectory: true)
//                            //.appendingPathComponent("com.alamofire.manager")
//                            .appendingPathComponent("multipart.form.data")
//                        do {
//                            try FileManager.default.removeItem(atPath: dir!.path)
//                        } catch {}
//                        Constants.printData(data: dataResponse.result.value as Any)
//                        success(dataResponse)
//                    }
//                })
//            case .failure(let encodingError):
//                failure(encodingError as NSError)
//                Constants.printData(data: encodingError)
//                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//            }
//        })
//    }
//    
//    /*************** FOR SINGLE IMAGES UPLOAD ****************/
//    
//    /*************** FOR MULTIPLE IMAGES UPLOAD ****************/
//    /*class func uploadMultipartFormData(_ strURL: String,
//                                       params: [String: AnyObject]?,
//                                       imagesData: [[String: Any]]?,
//                                       success:@escaping (DataResponse<Any>) -> Void,
//                                       failure:@escaping (NSError) -> Void) {
//        AF.upload(multipartFormData: { (multipartFormData) in
//            
//            for index: Int in 0..<(imagesData?.count ?? 0) {
//                if let imageData: Data = imagesData?[index]["data"] as? Data {
//                    multipartFormData.append(imageData,
//                                             withName: String(index),
//                                             fileName: String(Date().ticks)+".png",
//                                             mimeType: "image/png" )
//                }
//            }
//            for (key, value) in params ?? [:] {
//                multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
//            }
//        }, to: strURL, method: .post, headers: APIManager.headers(), encodingCompletion: { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.responseJSON(completionHandler: { (dataResponse) in
//                    if dataResponse.result.error != nil {
//                        if let error: Error = dataResponse.result.error {
//                            failure(error as NSError)
//                        }
//                        Constants.printData(data: dataResponse.result.error?.localizedDescription ?? "")
//                        
//                    } else {
//                        /*** delete temp files Alamofire generated ***/
//                        let temporaryDirectoryPath = NSTemporaryDirectory()
//                        let dir = NSURL(fileURLWithPath: temporaryDirectoryPath, isDirectory: true)
//                            //.appendingPathComponent("com.alamofire.manager")
//                            .appendingPathComponent("multipart.form.data")
//                        do {
//                            try FileManager.default.removeItem(atPath: dir!.path)
//                        } catch {}
//                        Constants.printData(data: dataResponse.result.value as Any)
//                        success(dataResponse)
//                    }
//                })
//            case .failure(let encodingError):
//                failure(encodingError as NSError)
//                Constants.printData(data: encodingError)
//                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//            }
//        })
//    }*/
//    /*************** FOR MULTIPLE IMAGES UPLOAD ****************/
//    
//    class func uploadInsuranceMultiImageMultipartFormData(_ strURL: String,
//                                       params: [String: AnyObject]?,
//                                       imagesData: [[String: Any]]?,
//                                       success:@escaping (DataResponse<Any>) -> Void,
//                                       failure:@escaping (NSError) -> Void) {
//        
//        AF.upload(multipartFormData: { (multipartFormData) in
//            
//            for index: Int in 0..<(imagesData?.count ?? 0) {
//                if let imageData: Data = imagesData?[index]["data"] as? Data {
//                    multipartFormData.append(imageData,
//                                             withName: String(index),
//                                             fileName: (imagesData?[index]["name"] as? String ?? "") + ".png",
//                                             mimeType: "image/png" )
//                }
//            }
////            for (key, value) in params ?? [:] {
////                multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
////            }
//            do {
//                let jsonData: Data = try JSONSerialization.data(withJSONObject: params ?? [], options: .prettyPrinted)
//                multipartFormData.append(jsonData, withName: "model")
//            } catch {
//               print(error.localizedDescription)
//            }
//        }, to: strURL, method: .post, headers: APIManager.headers(), encodingCompletion: { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.responseJSON(completionHandler: { (dataResponse) in
//                    if dataResponse.result.error != nil {
//                        if let error: Error = dataResponse.result.error {
//                            failure(error as NSError)
//                        }
//                        Constants.printData(data: dataResponse.result.error?.localizedDescription ?? "")
//                        
//                    } else {
//                        /*** delete temp files Alamofire generated ***/
//                        let temporaryDirectoryPath = NSTemporaryDirectory()
//                        let dir = NSURL(fileURLWithPath: temporaryDirectoryPath, isDirectory: true)
//                            //.appendingPathComponent("com.alamofire.manager")
//                            .appendingPathComponent("multipart.form.data")
//                        do {
//                            try FileManager.default.removeItem(atPath: dir!.path)
//                        } catch {}
//                        Constants.printData(data: dataResponse.result.value as Any)
//                        success(dataResponse)
//                    }
//                })
//            case .failure(let encodingError):
//                failure(encodingError as NSError)
//                Constants.printData(data: encodingError)
//                //Toast.showToast(message: Constants.internetConnectionErrorMsg)
//            }
//        })
//    }
//}


// MARK: - ParameterEncoding is needed while sending request as string with Alamofire instead of just Dictionary parameter "[String: Any]"
//extension String: ParameterEncoding {
//    
//    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
//        var request: URLRequest = try urlRequest.asURLRequest()
//        request.httpBody = data(using: .utf8, allowLossyConversion: false)
//        return request
//    }
//}

extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}
