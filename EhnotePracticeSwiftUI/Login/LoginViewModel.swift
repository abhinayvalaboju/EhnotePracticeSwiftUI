//
//  LoginViewModel.swift
//  EhnotePracticeSwiftUI
//
//  Created by Abhinay Chary on 3/26/25.
//

import SwiftUI
import CryptoSwift

class LoginViewModel: ObservableObject {
    @Published var loginResponse:LoginResponse?
    @Published var password: String = ""
    
    
    func loginUser(email: String, password: String, completion: @escaping (LoginResponse?) -> Void) {
        let deviceModel: String = UIDevice.current.model
        let osVersion    : String = ProcessInfo.processInfo.operatingSystemVersionString
        
        let iv = AES.randomIV(AES.blockSize)
        let ivBase64 = Data(iv).base64EncodedString()
        
        // Encrypt email and password with the SAME IV
        let encryptedEmail = AESCrypt.encryptWithIVBase64(email, ivBase64: ivBase64)
        let encryptedPassword = AESCrypt.encryptWithIVBase64(password, ivBase64: ivBase64)
        
        
            let requestData: [String: Any] = [
                "UserLoginID": encryptedEmail ?? "",
                "UserPassword": encryptedPassword ?? "",
                "LoggedIn": "Y",
                "TypeOfDevice": "49D6A9C7",
                "Lat": "37.7749",
                "Lon": "-122.4194",
                "IsFromAdmin": false,
                "MobileDeviceManufacturer": "iPhone",
                "MobileDeviceModel": deviceModel,
                "Platform": osVersion,
                "DeviceId": "your_device_token_here",
                "StatusType": "Login",
                "ivBase64": ivBase64
            ]

        APIManager.loginAPI(params: requestData, success: { response in
                DispatchQueue.main.async {
                    completion(response)  // Pass response back via closure
                }
            }, failure: { error in
                DispatchQueue.main.async {
//                    self.errorMessage = error.localizedDescription
                    completion(nil) // Pass nil in case of failure
                }
            })
        }
    
}
