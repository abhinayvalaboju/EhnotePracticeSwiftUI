//
//  Constants.swift
//  EhnotePracticeSwiftUI
//
//  Created by Abhinay Chary on 3/25/25.
//

import UIKit
import CryptoSwift

struct Constants {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static var country = "United States"
    
    static var globalLoginResponse: LoginResponse?
    static var parentHospitalID: Int?
    static let name: String = ""
//    static var allDoctorArr: [DeptRelatedDoctors] = []
//
////    static var slotList: [SlotList]?
//    static var slotList: [ClinicAppointmentList]?
//    static var visitReasonsArr:[ReasonsRow]?
    static var selHospID: Int?
    static var selHospName: String?
    static var selHospState: String?
    static var selHospCountry: String?
    static var selVisitReasonId: String?
    static var selDocIds: String?
    static var selVisitTypeId: String?
    
    static var selHospStateID: Int?
    static var selHospCountryID: Int?
    static var selSubOrgID: Int?
    static var selHospCode: String?
    static var globalHospitalList: [NHospitalList]?
    static var authorizationToken: String = ""
    static var globalTimer: Timer?
    
    static var isNewConsultationRestriction:Bool?
//    static var allMasterConsultationData:AllMasterConsultationData?
    
    static var selectedRoomType:String?
    
    // MARK: - UserDefault Keys
    static let emailID: String = "EmailID"
    static let password: String = "Password"
    static let loginStatus: String = "LoginStatus"
    static let loginResponse: String = "LoginResponse"
    static let selectedHospitalID: String = "SelectedHospitalID"
    static let selectedBranchName: String = "SelectedBranchName"
    static let selectedSubOrganizationID: String = "SelectedSubOrganizationID"
    static let selectedHsptlCode: String = "SelectedHospitalCode"
    static let selectedRoleID: String = "SelectedRoleID"
    static let selectedRoleName: String = "SelectedRoleName"
    static let selectedHospState: String = "SelectedHospState"
    static let selectedHospCountry: String = "SelectedHospCountry"
    static let selectedHospStateID: String = "SelectedHospStateID"
    static let selectedHospCountryID: String = "SelectedHospCountryID"
    static let fcmTokenStr: String = "FCMTOKEN"
    
//    static var country = UserDefaults.standard.value(forKey: "Country") as? String
//    static var  country = "United States"
    static var  isTabChecked = false
    
    static var dilationPupilODData = ""
    static var dilationPupilOSData = ""
    static var dilationPupilNotesData = ""
    
    // MARK: - To print All urls and responses
    static func printData(data: Any) {
//        if showRestData {
            print(data)
//        }
    }
}

class AESCrypt {
    
    private static let keyString = "123456789012345678901234"
    
    static func encrypt(_ plaintext: String) -> String? {
        do {
            let key = Array(keyString.utf8)
            let iv = AES.randomIV(AES.blockSize) // 16 bytes
            
            let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
            let encryptedBytes = try aes.encrypt(Array(plaintext.utf8))
            
            let combined = iv + encryptedBytes
            return Data(combined).base64EncodedString()
        } catch {
            print("Encryption error: \(error)")
            return nil
        }
    }
    
    static func decrypt(_ combinedBase64: String) -> String? {
        do {
            guard let combinedData = Data(base64Encoded: combinedBase64) else {
                return nil
            }
            
            let combinedBytes = [UInt8](combinedData)
            guard combinedBytes.count > AES.blockSize else {
                return nil
            }
            
            let iv = Array(combinedBytes[0..<AES.blockSize])
            let encryptedBytes = Array(combinedBytes[AES.blockSize...])
            
            let key = Array(keyString.utf8)
            
            let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
            let decryptedBytes = try aes.decrypt(encryptedBytes)
            
            return String(bytes: decryptedBytes, encoding: .utf8)
        } catch {
            print("Decryption error: \(error)")
            return nil
        }
    }
    
    static func encryptWithIVBase64(_ plaintext: String, ivBase64: String) -> String? {
        do {
            guard let ivData = Data(base64Encoded: ivBase64) else { return nil }
            let iv = [UInt8](ivData)
            let key = Array(keyString.utf8)
            
            let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
            let encryptedBytes = try aes.encrypt(Array(plaintext.utf8))
            
            return Data(encryptedBytes).base64EncodedString()
        } catch {
            print("Encryption error: \(error)")
            return nil
        }
    }
    
}
