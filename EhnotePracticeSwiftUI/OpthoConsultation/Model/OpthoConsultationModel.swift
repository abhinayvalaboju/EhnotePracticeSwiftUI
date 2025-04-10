//
//  OpthoConsultationModel.swift
//  EhnotePracticeSwiftUI
//
//  Created by K Naresh on 09/04/25.
//

import Foundation

struct GetUserConsultationitemsResponse: Codable {
    var status: String?
    var investigations: [Investigations]?
    var diagnosis: [OpthaDiagnosis]?
    var labTests: [OpthaLabTest]?
    var surgeryList: [OpthaSurgeryData]?
    var prescriptionFrequencies: [FrequencyObj]?
    var invCategories: [InvCategories]?
    
    
    enum CodingKeys: String, CodingKey {
        case status
        case investigations = "Findings"
        case diagnosis = "Diagnosis"
        case labTests = "LabTests"
        case surgeryList = "SurgeryList"
        case prescriptionFrequencies = "PrescriptionFrequencies"
        case invCategories = "InvCategories"
        //case
    }
}

// MARK: - Investigations

struct Investigations: Codable {
    
    let investigationID: Int?
    let categoryID: Int?
    let hospitalID: Int?
    let category: String?
    let investigation: String?
    let investigationDesc: String?
    var activeInd: String?
    let syncImageInd: String?
    let getTemplateInd: String?
    let leftTemplateUrl: String?
    let rightTemplateUrl: String?
    let imageUploadInd: String?
    let remarksInd: String?
    let frequencyValuesInd: String?
    let cdRatioValuesInd: String?
    let subCategoryChildID: Int?
    
    
    
    // these below for suggest Investigations
    var patientInvestigationId: Int?
    var patientSuggestInvID: Int?
    var investigationName: String?
    //var investigationID: Int?
    var investigationNotes, investigationInstruction: String?
    var organID, testType: Int?
    var isTreatmentInvoiced: Bool?
    var orgInvestigationId: Int64?
    var statusID: String?
    var cost, discount: Int?
    var organName: String?
    var invSpecialityId: Int?
    var imagesData: [ImagesData]?
    
    var modifiedBy: String?
    var modifiedDt: String?
    
    
   
    enum CodingKeys: String, CodingKey {
        case investigationID = "InvestigationId"
        case categoryID = "CategoryId"
        case hospitalID = "HospitalID"
        case category = "Category"
        case investigation = "Investigation"
        case investigationDesc = "InvestigationDesc"
        case activeInd = "ActiveInd"
        case syncImageInd = "SyncImageInd"
        case getTemplateInd = "GetTemplateInd"
        case leftTemplateUrl = "LeftTemplateUrl"
        case rightTemplateUrl = "RightTemplateUrl"
        case imageUploadInd = "ImageUploadInd"
        case remarksInd = "RemarksInd"
        case frequencyValuesInd = "FrequencyValuesInd"
        case cdRatioValuesInd = "CdRatioValuesInd"
        case subCategoryChildID = "SubCategoryChildId"
        
        
        case patientInvestigationId = "PatientInvestigationId"
        case patientSuggestInvID = "PatientSuggestInvId"
        case investigationName = "InvestigationName"
        //case investigationID = "InvestigationId"
        case investigationNotes = "InvestigationNotes"
        case investigationInstruction = "InvestigationInstruction"
        case organID = "OrganId"
        case testType = "TestType"
        case isTreatmentInvoiced = "IsTreatmentInvoiced"
        case orgInvestigationId = "OrgInvestigationId"
        case statusID = "StatusId"
        case cost = "Cost"
        case discount = "Discount"
        case organName = "OrganName"
        case invSpecialityId = "InvSpecialityId"
        case imagesData = "ImagesData"
        case modifiedBy = "ModifiedBy"
        case modifiedDt = "ModifiedDt"
    }
}

struct ImagesData: Codable {
    
}

// MARK: - Diagnosis start from here
struct OpthaDiagnosis: Codable {
    var patientDiagnosisID, organID, diagnosisHistoryID, diagnosisTypeID: Int?
    var diagnosisType, organName: String?
    var diagnosisID: Int?
    var diagnosisName, diagnosisNotes, diagnosisCode: String?
    var specializationID: Int?
    var notes: String?
    var activeInd: String?
    var fullName: String?
    var hospitalId, userId: Int16?
    var fromEditCons: Bool?
    var modifiedDt: String?
    var modifiedBy: String?
    
    enum CodingKeys: String, CodingKey {
        case patientDiagnosisID = "PatientDiagnosisId"
        case organID = "OrganId"
        case diagnosisHistoryID = "DiagnosisHistoryId"
        case diagnosisTypeID = "DiagnosisTypeId"
        case diagnosisType = "DiagnosisType"
        case organName = "OrganName"
        case diagnosisID = "DiagnosisId"
        case diagnosisName = "DiagnosisName"
        case diagnosisNotes = "DiagnosisNotes"
        case specializationID = "SpecializationId"
        case notes = "Notes"
        case activeInd = "ActiveInd"
        case fullName = "FullName"
        case hospitalId = "HospitalId"
        case userId = "UserId"
        case fromEditCons
        case modifiedDt = "ModifiedDt"
        case modifiedBy = "ModifiedBy"
        case diagnosisCode = "DiagnosisCode"
    }
}

//MARK: - OpthaLabTest Array start from here
struct OpthaLabTest: Codable {
    var labTestID, patientLabtestID: Int?
    var labTestName: String?
    var labTestCategoryID, organID, testType: Int?
    var isTreatmentInvoiced: Bool?
    var statusID: String?
    var cost, discount: Int?
    var activeInd: String?
    var organName, testPreparationInfo: String?
    var imagesData: [ImagesData]?
    var orgLabTestId: Int?
    var remarks: String?
    
    enum CodingKeys: String, CodingKey {
        case labTestID = "LabTestId"
        case patientLabtestID = "PatientLabtestId"
        case labTestName = "LabTestName"
        case labTestCategoryID = "LabTestCategoryId"
        case organID = "OrganId"
        case testType = "TestType"
        case isTreatmentInvoiced = "IsTreatmentInvoiced"
        case statusID = "StatusId"
        case cost = "Cost"
        case discount = "Discount"
        case activeInd = "ActiveInd"
        case organName = "OrganName"
        case testPreparationInfo = "TestPreparationInfo"
        case imagesData = "ImagesData"
        case orgLabTestId = "OrgLabTestId"
        case remarks = "Remarks"
    }
}

// MARK: - OpthaSurgeryData Array start from here
struct OpthaSurgeryData: Codable {
    var surgeryID: Int?
    var surgeryName: String?
    var fullSurgeryName: String?
    var orgSurgeryId: Int?
    var branchId: Int?
    var surgerBillingCost, orgSurgeryBillingID: Int?
    var surgeryBillingName: String?
    var specializationID, patientSurgeryID, parentPatientSurgeryId, organID, consultationID: Int?
    var organName: String?
    var surgeryDoctorID: Int?
    var surgeryDoctorName: String?
    var surgeryAnesthesiaDoctorID: Int?
    var surgeryAnesthesiaDoctorName: String?
    var surgerySuggestedDate, iolPower, surgeryInstructions, patientInstructions: String?
    var surgeryCounselorName: String?
    var surgeryCounselorId: Int?
    var surgeryCounselor: String?
    var surgeryStatus: String?
    var activeInd: String?
    var surgeryFinalCost: Int?
    var anesthesiaType: String?
    var surgeryOrganizationID, anesthesiaTypeID: Int?
    var parentPatientSurgeryID: Int?
    var surgeryObject: SurgeryObject?
    var surgeryBillingObject: BillingPackageList?
    var surgeryStatusId: Int?
    
    enum CodingKeys: String, CodingKey {
        case surgeryID = "SurgeryId"
        case orgSurgeryId = "OrgSurgeryId"
        case branchId = "BranchId"
        case surgeryName = "SurgeryName"
        case fullSurgeryName = "FullSurgeryName"
        case surgerBillingCost = "SurgerBillingCost"
        case orgSurgeryBillingID = "OrgSurgeryBillingId"
        case surgeryBillingName = "SurgeryBillingName"
        case specializationID = "SpecializationId"
        case patientSurgeryID = "PatientSurgeryId"
        case parentPatientSurgeryId = "ParentPatientSurgeryId"
        case organID = "OrganId"
        case organName = "OrganName"
        case consultationID = "ConsultationId"
        case surgeryDoctorID = "SurgeryDoctorId"
        case surgeryDoctorName = "SurgeryDoctorName"
        case surgeryAnesthesiaDoctorID = "SurgeryAnesthesiaDoctorId"
        case surgeryAnesthesiaDoctorName = "SurgeryAnesthesiaDoctorName"
        case surgerySuggestedDate = "SurgerySuggestedDate"
        case iolPower = "IolPower"
        case surgeryCounselorId = "SurgeryCounselorId"
        case surgeryCounselor = "SurgeryCounselor"
        case surgeryCounselorName = "SurgeryCounselorName"
        case surgeryInstructions = "SurgeryInstructions"
        case patientInstructions = "PatientInstructions"
        case surgeryStatus = "SurgeryStatus"
        case activeInd = "ActiveInd"
        case surgeryFinalCost = "SurgeryFinalCost"
        case anesthesiaType = "AnesthesiaType"
        case surgeryOrganizationID = "SurgeryOrganizationId"
        case anesthesiaTypeID = "AnesthesiaTypeId"
        case surgeryObject = "SurgeryObject"
        case surgeryBillingObject = "SurgeryBillingObject"
        case surgeryStatusId = "SurgeryStatusId"
    }
}

// MARK: - SurgeryObject
struct SurgeryObject: Codable {
    let orgSurgeryID: Int?
    let surgeryName: String?

    enum CodingKeys: String, CodingKey {
        case orgSurgeryID = "OrgSurgeryId"
        case surgeryName = "SurgeryName"
    }
}

struct BillingPackageList: Codable {
    let surgeryBillingName: String?
    let surgeryBillingPackageID: Int?
    let orgSurgeryBillingID: Int?
    let billingPackageCost: Int?
    let surgeryCost: Int?
    let cgsCost: Int?
    let sgsCost: Int?
    let insuranceCost: Int?
    let organizationSurgeryID: Int?
    let surgeryName: String?
    let surgeryID: Int?
    let branchName: String?
    let organizationID: Int?
    let billingCode: String?
    let procedureMaxDiscountValue: Int?
    let procedureMaxDiscountType: String?
    let procedureMaxDiscountCost: Int?
    let counsellorRemarks: String?
    let gst: Int?
    let statusID: String?
    let discountRemarks: String?
    let discountValue: Int?
    let discountType: String?
    let dicountAmount: Int?
    let isExclusiveTax: Bool?
    let deleteIND: String?
    
    enum CodingKeys: String, CodingKey {
        case surgeryBillingName = "SurgeryBillingName"
        case surgeryBillingPackageID = "SurgeryBillingPackageId"
        case orgSurgeryBillingID = "OrgSurgeryBillingId"
        case billingPackageCost = "BillingPackageCost"
        case surgeryCost = "SurgeryCost"
        case cgsCost = "CgsCost"
        case sgsCost = "SgsCost"
        case insuranceCost = "InsuranceCost"
        case organizationSurgeryID = "OrganizationSurgeryId"
        case surgeryName = "SurgeryName"
        case surgeryID = "SurgeryId"
        case branchName = "BranchName"
        case organizationID = "OrganizationId"
        case billingCode = "BillingCode"
        case procedureMaxDiscountValue = "ProcedureMaxDiscountValue"
        case procedureMaxDiscountType =  "ProcedureMaxDiscountType"
        case procedureMaxDiscountCost = "ProcedureMaxDiscountCost"
        case counsellorRemarks = "CounsellorRemarks"
        case gst = "GST"
        case statusID = "StatusId"
        case discountRemarks = "DiscountRemarks"
        case discountValue = "DiscountValue"
        case discountType = "DiscountType"
        case dicountAmount = "DiscountAmount"
        case isExclusiveTax = "IsExclusiveTax"
        case deleteIND = "DeleteInd"
    }
}

// MARK: - FrequencyObjClass
struct FrequencyObj: Codable {
    let frequencyID: Int?
    var name, frequencyType, code: String?
    let languages: [Language]?

    enum CodingKeys: String, CodingKey {
        case frequencyID = "FrequencyId"
        case name = "Name"
        case frequencyType = "FrequencyType"
        case code = "Code"
        case languages
    }
}

// MARK: - Investigations Category
struct InvCategories: Codable {
    let categoryID: Int?
    let categoryName: String?
    var hospitalID: Int?
    let activeInd: Bool?
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "CategoryId"
        case categoryName = "CategoryName"
        case hospitalID = "HospitalId"
        case activeInd = "ActiveIND"
    }
}
