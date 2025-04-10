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
    static let showRestData: Bool = true
    static var loadingView: UIView = UIView()
    static var globalLoginResponse: LoginResponse?
    static var parentHospitalID: Int?
    static let name: String = ""
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
    var allWaitingRoomListArr: [GetAllWaitingRoomTypeModel]?
    static var isNewConsultationRestriction:Bool?
   // static var allMasterConsultationData:AllMasterConsultationData?
    
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
    static var  country = "United States"
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
    
    static func getOSInfo() -> String {
        let operatingSystem = ProcessInfo().operatingSystemVersion
        return String(operatingSystem.majorVersion) + "." + String(operatingSystem.minorVersion) + "." + String(operatingSystem.patchVersion)
    }
    
    
    // MARK: - Email Regex
    static func isValidEmail(email: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    // MARK: - Show AlertView
    static func showAlertView(alertTitle: String,
                              alertMessage: String,
                              issingle: Bool,
                              viewController: UIViewController) {
        let alertController: UIAlertController = UIAlertController(title: alertTitle,
                                                                   message: alertMessage,
                                                                   preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        if !issingle {
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default))
        }
        viewController.present(alertController, animated: true, completion: nil)
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

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    private struct Interfaces {
        // INTERFACCIE SUPPORT
        static let wifi = ["en0"]
        static let wired = ["en2", "en3", "en4"]
        static let cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
        static let supported = wifi + wired + cellular
    }


    func getIPAdress() -> (String?,String?)? {
        var ip4Adress: String?
        var ip6Adress: String?
        var hasAdress: UnsafeMutablePointer<ifaddrs>?


        if getifaddrs(&hasAdress) == 0 {
            var pointer = hasAdress

            while pointer != nil {
                defer { pointer = pointer?.pointee.ifa_next}

                guard let interface = pointer?.pointee else {continue}

                // SEARCH FOR IPV4 OR IPV6 IN THE INTERFACE OF THE NODE
                // HERE I'M ALREADY LOOSING MY MIND
                // PRIORITY FOR IPV4 THAN IPV6
                if  interface.ifa_addr.pointee.sa_family == UInt8(AF_INET) {
                    guard let ip4 = processInterface(interface: interface) else {
                        continue
                    }
                    ip4Adress = ip4
                }

                if interface.ifa_addr.pointee.sa_family == UInt8(AF_INET6) {
                    guard let ip6 = processInterface(interface: interface) else {
                        continue
                    }
                    ip6Adress = ip6
                }
            }
            freeifaddrs(hasAdress)
        }
        return (ip4Adress, ip6Adress)
    }



    func processInterface(interface: ifaddrs) -> String? {

        var ipAdress: String = ""
        guard
            let interfaceName = interface.ifa_name else {return nil}
                           guard
                               let interfaceNameFormatted = String(cString: interfaceName, encoding: .utf8) else {return nil}
        guard Interfaces.supported.contains(interfaceNameFormatted) else {return nil}

                           var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))

                           print(interfaceNameFormatted)

                           // CONVERT THE SOCKET ADRESS TO A CORRESPONDING HOST AND SERVICE
                           getnameinfo(interface.ifa_addr,
                                       socklen_t(interface.ifa_addr.pointee.sa_len),
                                       &hostname, socklen_t(hostname.count),
                                       nil,
                                       socklen_t(0),
                                       NI_NUMERICHOST)

                           guard let formattedIpAdress = String(cString: hostname, encoding: .utf8) else {return nil}
                           if !formattedIpAdress.isEmpty {
                               ipAdress = formattedIpAdress
                           }
        return ipAdress
    }
}

// MARK: UIApplication extensions

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

// MARK: - Show AlertView
func showAlertView(alertTitle: String,
                          alertMessage: String,
                          issingle: Bool,
                          viewController: UIViewController) {
    let alertController: UIAlertController = UIAlertController(title: alertTitle,
                                                               message: alertMessage,
                                                               preferredStyle: UIAlertController.Style.alert)
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
    if !issingle {
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default))
    }
    viewController.present(alertController, animated: true, completion: nil)
}
