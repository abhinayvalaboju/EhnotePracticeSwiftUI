//
//  LoginModel.swift
//  EhnotePracticeSwiftUI
//
//  Created by Abhinay Chary on 3/26/25.
//

import Foundation

struct LoginRequest: Codable {
    let UserLoginID: String
    let UserPassword: String
    let LoggedIn: String
    let TypeOfDevice: String
    let Lat: Double
    let Lon: Double
    let IsFromAdmin: Bool
    let MobileDeviceManufacturer: String
    let MobileDeviceModel: String
    let Platform: String
    let DeviceId: String
    let StatusType: String
}

struct LoginResponse: Codable {
    let status: String?
    let mocCredentials: [MocCredentials]?
    let user: [User]?
    let userPhone: [UserPhone]?
    let userCommunicationPhone: [UserPhone]?
    let userAddress: [UserAddress]?
    let userEmail: [UserEmail]?
    let userConsultation: [UserConsultation]?
    let userEducation: [UserEducation]?
    let userPublishing, userAchievements, userAwards, userServices: [UserAchievementElement]?
    let userSpecilityDetails: [UserSpecilityDetail]?
    let userOtherDetails: UserOtherDetails?
    let userInvTemplates: [UserInvTemplate]?
    let userMemberships: [UserMemberShip]?
    let userSubOrganization: [UserSubOrganization]?
    let settingsData: SettingsData?
    var token, refreshToken, tokenExpireTime: String?
    var newHsptlList: [NHospitalList]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case mocCredentials = "MocCredentials"
        case user = "User"
        case userPhone = "UserPhone"
        case userCommunicationPhone = "UserCommunicationPhone"
        case userAddress = "UserAddress"
        case userEmail = "UserEmail"
        case userConsultation = "UserConsultation"
        case userEducation = "UserEducation"
        case userPublishing = "UserPublishing"
        case userAchievements = "UserAchievements"
        case userAwards = "UserAwards"
        case userServices = "UserServices"
        case userSpecilityDetails = "UserSpecilityDetails"
        case userOtherDetails = "UserOtherDetails"
        case userInvTemplates = "UserInvTemplates"
        case userMemberships = "UserMemberships"
        case userSubOrganization = "UserSubOrganization"
        case settingsData = "SettingsData"
        case token = "Token"
        case refreshToken = "RefreshToken"
        case tokenExpireTime = "TokenExpireTime"
        case newHsptlList = "row"
    }
}


struct MocCredentials: Codable {
    let apiEndpointURL:String?
    let applicationURL:String?
    
    enum CodingKeys: String, CodingKey{
        case apiEndpointURL = "APIEndpointURL"
        case applicationURL = "ApplicationURL"
    }
}

struct User: Codable {
    let fullName, firstName, lastName,suffix: String?
    let doctorID,suffixId: Int?
    let gender: String?
    let specializationID: Int?
    let specializationName, about, memberID: String?
    let exp: Int?
    let userLoginID, userEmailID: String?
    let communicationEmailID: String?
    let communicationMobNum: String?
    let communicationCountryCode: String?
    let communicationAreaCode: String?
    let userMobile: String?
    let prospect: String?
    let termsAccepted: String?
    let deleteIndicator: Bool?
    let active: String?
    let userType: String?
//    let patientTagList:[HsptlEquipmentData]?
    var isTwoWayVarificationInd: Bool?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "FullName"
        case firstName = "FirstName"
        case lastName = "LastName"
        case suffix = "Suffix"
        case suffixId = "SuffixId"
        case doctorID = "DoctorID"
        case gender = "Gender"
        case specializationID = "SpecializationId"
        case specializationName = "SpecializationName"
        case about = "About"
        case memberID = "MemberID"
        case exp = "Exp"
        case userLoginID = "UserLoginID"
        case userEmailID = "UserEmailId"
        case communicationEmailID = "CommunicationEmailId"
        case communicationMobNum = "CommunicationMobileNo"
        case communicationCountryCode = "CommunicationCountryCode"
        case communicationAreaCode = "CommunicationAreaCode"
        case userMobile = "UserMobile"
        case prospect = "Prospect"
        case termsAccepted = "TermsAccepted"
        case deleteIndicator = "DeleteIndicator"
        case active = "Active"
        case userType = "UserType"
//        case patientTagList = "PatientTagList"
        case isTwoWayVarificationInd = "IsTwoWayVarificationInd"
    }
}


struct UserPhone: Codable {
    let phCntryCD, phAreaCD: String?
    let phNumber: String?
    let phType: String?
    
    enum CodingKeys: String, CodingKey {
        case phCntryCD = "PhCntryCD"
        case phAreaCD = "PhAreaCD"
        case phNumber = "PhNumber"
        case phType = "PhType"
    }
}

struct UserSpecilityDetail: Codable {
    let serialNumber, specialityID: Int?
    let specialityDesc, subSpecialityDesc: String?
    
    enum CodingKeys: String, CodingKey {
        case serialNumber = "SerialNumber"
        case specialityID = "SpecialityID"
        case specialityDesc = "SpecialityDesc"
        case subSpecialityDesc = "SubSpecialityDesc"
    }
}

struct SettingsData: Codable {
    let diagnosisListSettings, treatmentListSettings, medicinesListSettings: [ListSetting]?
    let printerHeaderSettings: [PrintSetting]?
    let communicationsSettings: [CommunicationsSetting]?
    let complaintsListSettings, observationListSettings, clinicalNotesListSettings: [ListSetting]?
    let defaultInvTemplateSettings: [DefaultInvTemplateSetting]?
    
    enum CodingKeys: String, CodingKey {
        case diagnosisListSettings = "DiagnosisListSettings"
        case treatmentListSettings = "TreatmentListSettings"
        case medicinesListSettings = "MedicinesListSettings"
        case printerHeaderSettings = "PrinterHeaderSettings"
        case communicationsSettings = "CommunicationsSettings"
        case complaintsListSettings = "ComplaintsListSettings"
        case observationListSettings = "ObservationListSettings"
        case clinicalNotesListSettings = "ClinicalNotesListSettings"
        case defaultInvTemplateSettings = "DefaultInvTemplateSettings"
    }
}

// MARK: - ListSetting
struct ListSetting: Codable {
    let id: Int?
    let name: String?
    let type: String?
    let status: Bool?
    let hashKey: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case type = "Type"
        case status = "Status"
        case hashKey = "$$hashKey"
    }
}

// MARK: - CommunicationsSetting
struct CommunicationsSetting: Codable {
    let mode: String?
    let smsSettingsObj, emailSettingObj: SettingsObject?
   // let hashKey: String
    
    enum CodingKeys: String, CodingKey {
        case mode = "Mode"
        case smsSettingsObj = "SmsSettingsObj"
        case emailSettingObj = "EmailSettingObj"
        //case hashKey = "$$hashKey"
    }
}

// MARK: - Obj
struct SettingsObject: Codable {
    let appointment, billing, consultation, prescription: Bool?
    
    enum CodingKeys: String, CodingKey {
        case appointment = "Appointment"
        case billing = "Billing"
        case consultation = "Consultation"
        case prescription = "Prescription"
    }
}

// MARK: - DefaultInvTemplateSetting
struct DefaultInvTemplateSetting: Codable {
    let templateID: Int?
    
    enum CodingKeys: String, CodingKey {
        case templateID = "TemplateId"
    }
}

// MARK: - PrintSetting
struct PrintSetting: Codable {
    
}


// MARK: - User SubOrganization Data
struct UserSubOrganization: Codable {
    let subOrgID: Int?
    let subOrgName: String?
    
    enum CodingKeys: String, CodingKey {
        case subOrgID = "SubOrganizationId"
        case subOrgName = "SubOrganizationName"
    }
}

// MARK: Global Hospitals Array
struct BranchListData: Codable {
    var rows: [NHospitalList]?
    var roles: [NRole]?
    var subSpecialization: [NOrgSubSpecialities]?

    enum CodingKeys: String, CodingKey {
        case rows
        case roles = "Roles"
        case subSpecialization = "SubSpecialization"
    }
}

// MARK: - Role
struct NRole: Codable {
    let organizationRoleID, roleID: Int?
    let roleName: String?

    enum CodingKeys: String, CodingKey {
        case organizationRoleID = "OrganizationRoleId"
        case roleID = "RoleId"
        case roleName = "RoleName"
    }
}

// MARK: - Row
struct NHospitalList: Codable {
    var hospitalInfo: NHospitalInfo?
    var specialities: [NSpeciality]?
    var subSpecialities: [NBranchSubSpecialities]?
    var isAssignedHospital: Bool? = false

    enum CodingKeys: String, CodingKey {
        case hospitalInfo = "HospitalInfo"
        case specialities = "Specialities"
        case subSpecialities = "SubSpecialities"
        case isAssignedHospital
    }
}

// MARK: - HospitalInfo
struct NHospitalInfo: Codable {
    var hospitalDetails: NHospitalDetails?
    var hospitalAddress: NHospitalAddress?
    var hospitalPhone: [NHospitalPhone]?

    enum CodingKeys: String, CodingKey {
        case hospitalDetails = "HospitalDetails"
        case hospitalAddress = "HospitalAddress"
        case hospitalPhone = "HospitalPhone"
    }
}

// MARK: - HospitalAddress
struct NHospitalAddress: Codable {
    var address1, address2: String?
    var hno: String?
    var location: String?
    var cityID, stateID, countryID: Int?
    var pinCode, longitude, latitude, countryName: String?
    var stateName, cityName: String?
    var entityTypeID: Int?
    var entityType: String?

    enum CodingKeys: String, CodingKey {
        case address1 = "Address1"
        case address2 = "Address2"
        case hno = "Hno"
        case location = "Location"
        case cityID = "CityId"
        case stateID = "StateId"
        case countryID = "CountryId"
        case pinCode = "PinCode"
        case longitude = "Longitude"
        case latitude = "Latitude"
        case countryName = "CountryName"
        case stateName = "StateName"
        case cityName = "CityName"
        case entityTypeID = "EntityTypeId"
        case entityType = "EntityType"
    }
}

// MARK: - HospitalDetails
struct NHospitalDetails: Codable {
    var parentOrganizationID: Int?
    var hospitalCode: String?
    var subOrganizationID, branchID: Int?
    var branchName: String?
    var organizationTypeID: Int?
    var organizationType: String?
    var mobileNumber: String?
    var emailAddress, regsistrationDate, licenseNumber, tinNumber: String?
    var feedBackURL: String?
    var isAllowUserStockUsage: Bool?
    var isPrintInsturctions: String?
    var isRestrictAppointmentSlot, isSMSInd: Bool?
    var isSurgeryCostRestricted: Bool?
    var maxSMSCount: Int?
    var navigationURL: String?
    var smsPurchased: Int?
    var smsSenderID: String?
    var activeIND, termsAccepted, branchCode: String?
    var isNewConsultationRestriction: Bool?

    enum CodingKeys: String, CodingKey {
        case parentOrganizationID = "ParentOrganizationId"
        case hospitalCode = "HospitalCode"
        case subOrganizationID = "SubOrganizationId"
        case branchID = "BranchId"
        case branchName = "BranchName"
        case organizationTypeID = "OrganizationTypeId"
        case organizationType = "OrganizationType"
        case mobileNumber = "MobileNumber"
        case emailAddress = "EmailAddress"
        case regsistrationDate = "RegsistrationDate"
        case licenseNumber = "LicenseNumber"
        case tinNumber = "TINNumber"
        case feedBackURL = "FeedBackURL"
        case isAllowUserStockUsage = "IsAllowUserStockUsage"
        case isPrintInsturctions = "IsPrintInsturctions"
        case isRestrictAppointmentSlot = "IsRestrictAppointmentSlot"
        case isSMSInd = "IsSMSInd"
        case isSurgeryCostRestricted = "IsSurgeryCostRestricted"
        case maxSMSCount = "MaxSMSCount"
        case navigationURL = "NavigationURL"
        case smsPurchased = "SMSPurchased"
        case smsSenderID = "SMSSenderId"
        case activeIND = "ActiveIND"
        case termsAccepted = "TermsAccepted"
        case branchCode = "BranchCode"
        case isNewConsultationRestriction = "IsNewConsultationRestriction"
    }
}

// MARK: - HospitalPhone
struct NHospitalPhone: Codable {
    var phCntryCD, phAreaCD: String?
    var phNumber: String?
    var phType: String?

    enum CodingKeys: String, CodingKey {
        case phCntryCD = "PhCntryCD"
        case phAreaCD = "PhAreaCD"
        case phNumber = "PhNumber"
        case phType = "PhType"
    }
}

// MARK: - Speciality
struct NSpeciality: Codable {
    let branchOrgSpecializationID, specializationID: Int?
    let specializationName: String?

    enum CodingKeys: String, CodingKey {
        case branchOrgSpecializationID = "BranchOrgSpecializationId"
        case specializationID = "SpecializationId"
        case specializationName = "SpecializationName"
    }
}

// MARK: - Branch Sub Speciality
struct NBranchSubSpecialities: Codable {
    var branchSubSpecializationID, subSpecializationID: Int?
    var subSpecializationName: String?
    var specializationID: Int?
    var isPrimarySubSpec: Bool?

    enum CodingKeys: String, CodingKey {
        case branchSubSpecializationID = "BranchSubSpecializationId"
        case subSpecializationID = "SubSpecializationId"
        case subSpecializationName = "SubSpecializationName"
        case specializationID = "SpecializationId"
        case isPrimarySubSpec = "IsPrimarySubSpecialization"
    }
}

// MARK: - Organization Sub Speciality
struct NOrgSubSpecialities: Codable {
    let orgSubSpecializationID, subSpecializationID: Int?
    let subSpecializationName: String?

    enum CodingKeys: String, CodingKey {
        case orgSubSpecializationID = "OrgSubSpecializationId"
        case subSpecializationID = "SubSpecializationId"
        case subSpecializationName = "SubSpecializationName"
    }
}

struct UserAddress: Codable {
    let parentOrgID: Int?
    let subOrgID: Int?
    let userBranchID: Int?
    let clinicName: String?
    let clinicID: Int?
    let address1, address2, branchEmail: String?
    let mobileNo: String?
    let districtRegion: String?
    let stateID: Int?
    let pinCode: String?
    let countryID, cityID: Int?
    let addressType: String?
    let active: String?
    let latitude, longitude, location, cityName: String?
    let stateName, countryName: String?
    let extDetails: EXTDetails?
    let userDepartments: [UserDepartments]?
    let pharmacyName: String?
    let pharmacyInstructions: [Language]?
    let opticalInstructions: [Language]?
    let charges: String?
    let isAppRestricted: Bool?
    let smsSenderId: String?
    let userBranchRoles: [UserBranchRoles]?
    let parentOrganizationName: String?
    let roleID: Int?
    let roleName: String?
    let connectedUsers:[ConnectedUsers]?
    
    enum CodingKeys: String, CodingKey {
        case parentOrgID = "ParentOrganizationId"
        case subOrgID = "SubOrganizationId"
        case userBranchID = "UserBranchId"
        case clinicName = "ClinicName"
        case clinicID = "ClinicId"
        case address1 = "Address1"
        case address2 = "Address2"
        case branchEmail = "BranchEmail"
        case mobileNo = "MobileNo"
        case districtRegion = "DistrictRegion"
        case stateID = "StateId"
        case pinCode = "PinCode"
        case countryID = "CountryId"
        case cityID = "CityId"
        case addressType = "AddressType"
        case active = "Active"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case location = "Location"
        case cityName = "CityName"
        case stateName = "StateName"
        case countryName = "CountryName"
        case extDetails = "ExtDetails"
        case userDepartments = "UserDepartments"
        case pharmacyName = "PharmacyName"
        case pharmacyInstructions = "PharmacyInstructions"
        case opticalInstructions = "OpticalInstructions"
        case charges = "Charges"
        case isAppRestricted = "IsRestrictAppointmentSlot"
        case smsSenderId = "SMSSenderId"
        case userBranchRoles = "UserBranchRoles"
        case parentOrganizationName = "ParentOrganizationName"
        case roleID = "RoleId"
        case roleName = "RoleName"
        case connectedUsers = "ConnectedUsers"
    }
}

struct EXTDetails: Codable {
    let hospitalID: Int?
    let primaryIND: String?
    let hospitalInfo: HospitalInfo?
    let roleID: Int?
    let roleName, roleDesc: String?
    let groupID: Int?
    let groupName: String?
    let groupProfileID, minPerCase, teleMinPerCase: Int?
    
    enum CodingKeys: String, CodingKey {
        case hospitalID = "HospitalID"
        case primaryIND = "PrimaryIND"
        case hospitalInfo = "HospitalInfo"
        case roleID = "RoleID"
        case roleName = "RoleName"
        case roleDesc = "RoleDesc"
        case groupID = "GroupID"
        case groupName = "GroupName"
        case groupProfileID = "GroupProfileId"
        case minPerCase = "MinPerCase"
        case teleMinPerCase = "TeleMinPerCase"
    }
}

struct UserDepartments: Codable {
    
    var departmentRole: String?
    var departmentRoleId = 0
    var orgDepartmentId = 0
    var departmentName: String?
    var departmentId = 0
    
    enum CodingKeys: String, CodingKey {
        case departmentRole = "DepartmentRole"
        case departmentRoleId = "DepartmentRoleId"
        case orgDepartmentId = "OrgDepartmentId"
        case departmentName = "DepartmentName"
        case departmentId = "DepartmentId"
    }
}

struct ConnectedUsers: Codable {
    var branchId: Int?
    var childUserId: Int?
    var connectedUserId: Int?
    var parentUserId: Int?
    var deleteInd: String?
    //var accessDetails: [NUserAccessDetails]?
    
    enum CodingKeys: String, CodingKey {
        case branchId = "BranchId"
        case childUserId = "ChildUserId"
        case connectedUserId = "ConnectedUserId"
        case deleteInd = "DeleteInd"
        case parentUserId = "ParentUserId"
        //case accessDetails = "AccessDetails"
    }
}


struct UserBranchRoles: Codable {
    var userBranchRoleID: Int?
    var roleID: Int?
    var groupID: Int?
    var groupProfileID: Int?
    var roleName: String?
    var groupName: String?
    //var accessDetails: [NUserAccessDetails]?
    
    enum CodingKeys: String, CodingKey {
        case userBranchRoleID = "UserBranchRoleId"
        case roleID = "RoleId"
        case groupID = "GroupId"
        case groupProfileID = "GroupProfileId"
        case roleName = "RoleName"
        case groupName = "GroupName"
        //case accessDetails = "AccessDetails"
    }
}

struct HospitalInfo: Codable {
    let hospitalID: Int?
    let hospitalCode: String?
    let subHsptlID: Int?
    let parentHospitalID, organizationTypeID: Int?
    let organizationType: String?
    let preference: Preference?
    
    enum CodingKeys: String, CodingKey {
        case hospitalID = "HospitalID"
        case hospitalCode = "HospitalCode"
        case subHsptlID = "SubHospitalID"
        case parentHospitalID = "ParentHospitalID"
        case organizationTypeID = "OrganizationTypeId"
        case organizationType = "OrganizationType"
        case preference = "Preference"
    }
}

struct Preference: Codable {
    let patientDisplayID, patHoscdDisplay: String?
    let billID: String?
    let lastBillNumber, billNumber: Int?
    let invoiceID: String?
    let lastInvoiceNumber, invoiceNumber, patSeqDisplay: Int?
    
    enum CodingKeys: String, CodingKey {
        case patientDisplayID = "PatientDisplayID"
        case patHoscdDisplay = "PAT_HOSCD_DISPLAY"
        case billID = "BillID"
        case lastBillNumber = "LastBillNumber"
        case billNumber = "BillNumber"
        case invoiceID = "InvoiceID"
        case lastInvoiceNumber = "LastInvoiceNumber"
        case invoiceNumber = "InvoiceNumber"
        case patSeqDisplay = "PAT_SEQ_DISPLAY"
    }
}

/*struct UserAccessID: Codable {
    let accessCategoryID: Int?
    let accessCategoryName: String?
    let activeInd: String?
    let accessList: [AccessList]?
    let isAllCategoryItemsSelected: Bool?
    let hashKey: String?
    
    enum CodingKeys: String, CodingKey {
        case accessCategoryID = "AccessCategoryId"
        case accessCategoryName = "AccessCategoryName"
        case activeInd = "ActiveInd"
        case accessList = "AccessList"
        case isAllCategoryItemsSelected
        case hashKey = "$$hashKey"
    }
}

struct AccessList: Codable {
    let accessRightID: Int?
    let accessRightName: String?
    let accessCategoryID: Int?
    let activeInd: String?
    let hashKey: String?
    
    enum CodingKeys: String, CodingKey {
        case accessRightID = "AccessRightId"
        case accessRightName = "AccessRightName"
        case accessCategoryID = "AccessCategoryId"
        case activeInd = "ActiveInd"
        case hashKey = "$$hashKey"
    }
}*/

struct UserConsultation: Codable {
    let userBranchID, userBranchConsultID, doctorID: Int?
    let dayCD: String?
    let startTime, endTime: String?
    let minPerCase: Int?
    let active: String?
    
    enum CodingKeys: String, CodingKey {
        case userBranchID = "UserBranchId"
        case userBranchConsultID = "UserBranchConsultID"
        case doctorID = "DoctorID"
        case dayCD = "DayCD"
        case startTime = "StartTime"
        case endTime = "EndTime"
        case minPerCase = "MinPerCase"
        case active = "Active"
    }
}

struct UserEducation: Codable {
    let rowID: Int?
    let educationName, instituteName, yearOfPassedOut: String?
    let startYear, endYear: Int?
    
    enum CodingKeys: String, CodingKey {
        case rowID = "RowID"
        case educationName = "EducationName"
        case instituteName = "InstituteName"
        case yearOfPassedOut = "YearOfPassedOut"
        case startYear = "StartYear"
        case endYear = "EndYear"
    }
}

struct UserEmail: Codable {
    let emailID: String?
    let primaryIND: String?
    let emailIDType: String?
    let crtUSR: Int?
    let crtUSRType: String?
    let updtUSR: Int?
    let updtUSRType: String?
    
    enum CodingKeys: String, CodingKey {
        case emailID = "EmailID"
        case primaryIND = "PrimaryIND"
        case emailIDType = "EmailIDType"
        case crtUSR = "CrtUSR"
        case crtUSRType = "CrtUSRType"
        case updtUSR = "UpdtUSR"
        case updtUSRType = "UpdtUSRType"
    }
}

struct UserInvTemplate: Codable {
    let templateID: Int?
    let templateName: String?
    let doctorID: Int?
    let activeInd: String?
    let templateDetails: [TemplateDetail]?
    
    enum CodingKeys: String, CodingKey {
        case templateID = "TemplateId"
        case templateName = "TemplateName"
        case doctorID = "DoctorID"
        case activeInd = "ActiveInd"
        case templateDetails = "TemplateDetails"
    }
}

struct UserMemberShip: Codable {
    let rowID: Int?
    let name: String?
    let indicator: String?
    
    enum CodingKeys: String, CodingKey {
        case rowID = "RowID"
        case name = "Name"
        case indicator = "Indicator"
    }
}

struct TemplateDetail: Codable {
    let row: Int?
    let rIndividualTempID, lIndividualTempID: String?
    let categoryID: Int?
    let categoryName: String?
    let investigationID, templateID: Int?
    let name: String?
    let activeInd, syncImageInd, getTemplateInd: String?
    let leftTemplateURL, rightTemplateURL: String?
    let imageUploadInd, remarksInd, frequencyValuesInd, cdRatioValuesInd: String?

    enum CodingKeys: String, CodingKey {
        case row
        case rIndividualTempID = "RIndividualTempId"
        case lIndividualTempID = "LIndividualTempId"
        case categoryID = "CategoryId"
        case categoryName = "CategoryName"
        case investigationID = "InvestigationId"
        case templateID = "TemplateId"
        case name = "Name"
        case activeInd = "ActiveInd"
        case syncImageInd = "SyncImageInd"
        case getTemplateInd = "GetTemplateInd"
        case leftTemplateURL = "LeftTemplateUrl"
        case rightTemplateURL = "RightTemplateUrl"
        case imageUploadInd = "ImageUploadInd"
        case remarksInd = "RemarksInd"
        case frequencyValuesInd = "FrequencyValuesInd"
        case cdRatioValuesInd = "CdRatioValuesInd"
    }
}

struct UserOtherDetails: Codable {
    let firstName, lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "FirstName"
        case lastName = "LastName"
    }
}

struct UserAchievementElement: Codable {
    let rowID: Int?
    let name, indicator: String?
    
    enum CodingKeys: String, CodingKey {
        case rowID = "RowID"
        case name = "Name"
        case indicator = "Indicator"
    }
}

// MARK: - Language
struct Language: Codable {
    let language: String?
    let translateName: String?

    enum CodingKeys: String, CodingKey {
        case language = "Language"
        case translateName
    }
}
