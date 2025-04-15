//
//  LoginViewModel.swift
//  EhnotePracticeSwiftUI
//
//  Created by Abhinay Chary on 3/26/25.
//

import Foundation
import SwiftUI
import Alamofire
import CryptoSwift

class LoginViewModel: ObservableObject {
    
    @Published var loginResponse: LoginResponse?
    @Published var branchListData: BranchListData?
    @Published var userConsultationitemsObj: GetUserConsultationitemsResponse?
    @Published var getAllWaitingRoomListArr: [GetAllWaitingRoomTypeModel]?
    // @Published var getAllWaitingRoomListArr: [GetAllWaitingRoomTypeModel]?
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var userLatitude: String = ""
    @Published var userLongitude: String = ""
    
    func loginUser(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        isLoading = true
        
        let deviceModel = UIDevice.current.model
        let osVersion = ProcessInfo.processInfo.operatingSystemVersionString
        let deviceToken: String = UserDefaults.standard.string(forKey: Constants.fcmTokenStr) ?? ""
        
        let email = email
        let password = password
        
        let iv = AES.randomIV(AES.blockSize)
        let ivBase64 = Data(iv).base64EncodedString()
        
        // Encrypt email and password with the SAME IV
        let encryptedEmail = AESCrypt.encryptWithIVBase64(email, ivBase64: ivBase64)
        let encryptedPassword = AESCrypt.encryptWithIVBase64(password, ivBase64: ivBase64)
        
        let parameters: [String: Any] = [
            "UserLoginID": encryptedEmail ?? "",
            "UserPassword": encryptedPassword ?? "",
            "LoggedIn": "Y",
            "TypeOfDevice": "49D6A9C7",
            "Lat": userLatitude,
            "Lon": userLongitude,
            "IsFromAdmin": false,
            "MobileDeviceManufacturer": "iPhone",
            "MobileDeviceModel": UIDevice.current.modelName,
            "Platform": Constants.getOSInfo(),
            "DeviceId": deviceToken,
            "ivBase64": ivBase64
        ]
        
        APIRequest.loginAPI(params: parameters,
                            success: { [weak self] response in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.loginResponse = response
                completion(.success(response))
            }
        },
                            failure: { [weak self] error in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                completion(.failure(error))
            }
        })
    }
    
    func getBranchesListByID(subOrgID: Int?, completion: @escaping (Result<BranchListData, Error>) -> Void) {
        
        let parameters: [String: Any] = ["SubOrganizationId": subOrgID ?? 0]
        
        APIRequest.getBranchesListByIdAPI(params: parameters,
                                          success: { [weak self] response in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.branchListData = response
                completion(.success(response))
            }
        },
                                          failure: { [weak self] error in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                completion(.failure(error))
            }
        })
    }
    
    func getUserConsultationitems(userId: Int,
                                  hospitalId: Int) {
        print("Starting consultation items fetch for userId: \(userId), hospitalId: \(hospitalId)")
        let parameters: [String: Any] = [
            "UserId": userId,
            "HospitalID": hospitalId
        ]
        
        APIRequest.getUserConsultationitemsAPI(params: parameters,
                                               success: { [weak self] response in
            DispatchQueue.main.async {
                self?.isLoading = false
                print("Consultation items fetch success")
                self?.userConsultationitemsObj = response
            }
        },
                                               failure: { [weak self] error in
            DispatchQueue.main.async {
                print("Consultation items fetch failed: \(error.localizedDescription)")
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
            }
        })
    }
    
    func getAllWaitingRoomList() {
        self.isLoading = true
        APIRequest.getAllWaitingRoomTypeAPI(params: [:]) { [weak self] response in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.getAllWaitingRoomListArr = [response]
            }
        } failure: { error in
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

