//
//  ApiRequest.swift
//  EhnotePracticeSwiftUI
//
//  Created by Abhinay Chary on 3/25/25.
//

import UIKit
import Alamofire

class Configuration {
    static let shared: Configuration = Configuration()
    private init() {}
    //    var environment: Env = Env.development
    var environment: Env = Env.development
//    var environment: Env = Env.production
}
 
enum Env {
    case development
    case staging
    case production
    case qa
}

class baseURL {
    
    private let USABaseURLDev = "https://ehrusdevapi.azurewebsites.net/api/"
  //  private let USABaseURLDev = "https://ehnoteehrdevapi.azurewebsites.net/api/"
    private let USABaseURLStag =  "https://ehnoteehrstageapi.azurewebsites.net/api/"
    private let USABaseURLProd =  "https://ehnoteprodehrapi.azurewebsites.net/api/"
    
    private let IndBaseURLDev = "https://devehnoteapi.azurewebsites.net/api/"
    private let IndBaseURLStag = "https://ehnotestagedocapi.azurewebsites.net/api/"
    private let IndBaseURLProd = "https://ehnotedocapi.azurewebsites.net/api/"
    
    func getBaseURL() -> String {
        let env: Env = Configuration.shared.environment
        var path = ""
        if env == Env.development {
            //                        return "https://devehnoteapi.azurewebsites.net/api/"
            if(Constants.country == "India"){
               // return IndBaseURLDev
                return USABaseURLDev
            } else if(Constants.country == "United States"){
                return USABaseURLDev
            }else {
                return USABaseURLDev
            }
        } else if env == Env.staging {
            //            return "https:/ehnotestagedocapi.azurewebsites.net/api/"
            if(Constants.country == "India"){
                //                return IndBaseURLStag
                if let url = UserDefaults.standard.value(forKey: "productionEndUrl") as? String {
                    path = url
                }
                
                if(path != "")
                {
                    return path
                }else {
                    return IndBaseURLStag
                }
            } else if(Constants.country == "United States"){
                //                return USABaseURLStag
                if let url = UserDefaults.standard.value(forKey: "productionEndUrl") as? String {
                    path = url
                }
                
                if(path != "")
                {
                    return path
                }else {
                    return USABaseURLStag
                }
            }else {
                return USABaseURLStag
            }
        } else if env == Env.qa {
            return "https://ehnoteehrqaapi.azurewebsites.net/api/"
            //        https://ehnoteehrqaapi.azurewebsites.net
        } else {
            //            return "https://ehnotedocapi.azurewebsites.net/api/"
            //return "https://ehnotedocapi1.azurewebsites.net/api/"
            if(Constants.country == "India"){
                //                return IndBaseURLProd
                if let url = UserDefaults.standard.value(forKey: "productionEndUrl") as? String {
                    path = url
                }
                
                if(path != "")
                {
                    return path
                }else {
                    return IndBaseURLProd
                }
            }
            else if(Constants.country == "United States")
            {
                //                return USABaseURLStag
                if let url = UserDefaults.standard.value(forKey: "productionEndUrl") as? String {
                    path = url
                }
                
                if(path != "")
                {
                    return path
                }else {
                    return USABaseURLProd
                }
            }else {
                return USABaseURLProd
            }
        }
    }
}

class URLS {
    
    let loginURL: String = baseURL().getBaseURL() + "Admin/NewValidateUserLogin"
    
    let getDilationHistory:String = baseURL().getBaseURL() + "Patient/GetDilationHistory"
    
    let getValidateDoctor:String = baseURL().getBaseURL() + "Admin/GetValidDoctor"
    let getDoctorsURL: String = baseURL().getBaseURL() + "Admin/GetDoctors"
    let getOrSearchPatientsURL: String = baseURL().getBaseURL() + "Patient/SearchPatientWeb"
//    let getOrSearchPatientsURL: String = baseURL().getBaseURL() + "Patient/GetPatientsSearchAll"
    let searchOrRegisterPatientURL: String = baseURL().getBaseURL() + "Patient/GetPatientsForAutocomplete"
    let getHsptlRelatedPatientsByMobileURL: String = baseURL().getBaseURL() + "Patient/getHospitalPatientsByMobile"
    let addorUpdatePatientURL: String = baseURL().getBaseURL() + "Patient/AddUpdatePatientNewRegister"
    let usAddorUpdatePatientURL: String = baseURL().getBaseURL() + "Patient/AddUpdatePatientNewRegister"
//    let getDoctorAvailableAppointmentURL: String = baseURL().getBaseURL() + "Patient/GetDoctorAvailableAppointment"
    let getDoctorAvailableAppointmentURL: String = baseURL().getBaseURL() + "Patient/GetNewListofAppointmentsnew"
    let getPatientDynamicStatusListByTypenew: String = baseURL().getBaseURL() + "Patient/GetPatientDynamicStatusListByTypenew"
    let getAppointmentListURL: String = baseURL().getBaseURL() + "Patient/GetPatientFollowupAppointments"
    let getPatientNoteFilesbyId: String = baseURL().getBaseURL() + "MasterData/GetPatientNoteFilesbyId"
    let getCheckAppointmentURL: String = baseURL().getBaseURL() + "Consultation/CheckAppointment"
    let addUpdateAppointmentURL: String = baseURL().getBaseURL() + "Patient/AddUpdateAppointmentNew"
    let addPatientConsultationImage: String = baseURL().getBaseURL() + "MasterData/AddPatientConsultationImage"
    let modifyDentalConsultationURL: String = baseURL().getBaseURL() + "Consultation/ModifyDentalConsultation"
    let getPatientVisitReasonURL: String = baseURL().getBaseURL() + "Patient/GetPatientVisitReason"
    let getPatientCancelVisitReasonURL: String = baseURL().getBaseURL() + "Setting/GetOrganizationCancelVisitReasons"
    let GetPatientVisitReasonWithPageNationURL: String = baseURL().getBaseURL() + "MasterData/GetPatientVisitReasonWithPageNation"
    let getAllSpecialitiesURL: String = baseURL().getBaseURL() + "MasterData/GetAllSpeciality"
    let getModifyPatientConsultationImgURL: String = baseURL().getBaseURL() + "MasterData/ModifyPatientConsultationImg"
    let getDeletePatientConsultationImgURL: String = baseURL().getBaseURL() + "MasterData/DeletePatientConsultationImg"
    let getChangePasswordServiceURL: String = baseURL().getBaseURL() + "Admin/ChangePassword"
    let getMainDashboardURL: String = baseURL().getBaseURL() + "Admin/GetMainDashBoardDetails"
    let getIndividualDashboardURL: String = baseURL().getBaseURL() + "Admin/GetIndividualDashBoardDetails"
    // Presently not using this
    let getUserPlayDataURL: String = baseURL().getBaseURL() + "MasterData/getUserPlayData"
    //-------------------
    
    let getUserConsultationitemsURL: String = baseURL().getBaseURL() + "MasterData/GetUserConsultationitems"
    
    let checkInsuranceAvailableURL: String = baseURL().getBaseURL() + "Patient/CheckInsuranceTpaAvailinBranch"
    
    let getPatientBillingIDsURL: String = baseURL().getBaseURL() + "Consultation/GetPatientBillingIds"
    let getPatientBillingDetailsURL: String = baseURL().getBaseURL() + "Consultation/GetPatientBillingDetailsById"
    let getBillReceiptDetailsURL: String = baseURL().getBaseURL() + "Consultation/GetBillReceiptDtlsById"
    let getProcedureTypeURL: String = baseURL().getBaseURL() + "Patient/GetProcedureType"
    let getMasterProceduresURL: String = baseURL().getBaseURL() + "MasterData/GetMasterProcedures"
    let getAllCardTypesURL: String = baseURL().getBaseURL() + "MasterData/GetAllCardTypes"
    let getConsultationTreatmentsURL: String = baseURL().getBaseURL() + "Consultation/GetConsultationTreaments"
    let getDentalConsultationTreatmentsURL: String = baseURL().getBaseURL() + "Consultation/GetDentalConsultationTreaments"
    let modifyPatientAppointmentBillingURL: String = baseURL().getBaseURL() + "Consultation/ModifyAppointmentPatientBilling"
    let getMainDashboardDetailsForMobileURL: String = baseURL().getBaseURL() + "Admin/GetMainDashboardDetailsForMobile"
    let getDashBoardDetailInfoForMobileURL: String = baseURL().getBaseURL() + "Admin/GetDashBoardDetailInfoForMobile"
    let getOpthalPatientCaseHistory: String = baseURL().getBaseURL() + "Consultation/GetOpthaPatientCaseHistory"
    let getPatientDentalCaseHistorybyIdURL: String = baseURL().getBaseURL() + "Consultation/GetPatientDentalCaseHistorybyId"
    let getPatientTreatPlanDtlsURL: String = baseURL().getBaseURL() + "Consultation/GetPatientConsultationDetailsByApptId"
    let getPatientInvestigationResultById: String = baseURL().getBaseURL() + "Patient/GetPatientInvestigationResultById"
    
    let getParentChildAppointmentDetailsURL: String = baseURL().getBaseURL() + "Consultation/GetParentAndChildAppointmentDetails"
    let getMedicalConditonHistoriesByPatientIdURL: String = baseURL().getBaseURL() + "Consultation/GetMedicalConditonHistoriesByPatientId"
    let getProceduresByTypeURL: String = baseURL().getBaseURL() + "MasterData/GetProceduresByType"
    let getOrgSurgeryListURL: String = baseURL().getBaseURL() + "Surgery/GetOrganizationSurgeryList"
    let getOrgBillingPackageURL: String = baseURL().getBaseURL() + "Surgery/GetOrganizationBillingPackage"
    let getPatientAdvanceAmountURL: String = baseURL().getBaseURL() + "Patient/GetPatientAdvanceAmount"
    let getDilationMedicationURL: String = baseURL().getBaseURL() + "MasterData/GetOrgDilationMedication"
    let modifyPatientDilationURL: String = baseURL().getBaseURL() + "Patient/ModifyPatientDilation"
    let getPatientDentalTreatmentImagesURL: String = baseURL().getBaseURL() + "MasterData/GetPatientDentalTreatmentImages"
    let deleteDentalPatientTreatmentImgURL: String = baseURL().getBaseURL() + "MasterData/DeleteDentalPatientTreatmentImg"
    let addPatientDentalTreatmentImage: String = baseURL().getBaseURL() + "MasterData/AddDentalPatientTreatmentImages"
    let getPatientTreatmentsByApptIdURL: String = baseURL().getBaseURL() + "Consultation/GetPatientTreatmentsByApptId"
    // This is old one
    let getFrequentlyAddedItemsURL: String = baseURL().getBaseURL() + "MasterData/GetFrequentlyAddedItems"
    
    // This is new one
    let getFrequentConsltationItemsURL: String = baseURL().getBaseURL() + "MasterData/GetFrequentConsltationItems"
    
    let getMasterMedicinesURL: String = baseURL().getBaseURL() + "MasterData/GetMasterMedicines"
    let addDentalSittingURL: String = baseURL().getBaseURL() + "Consultation/AddDentalSitting"
    let getDocAvailableSlotsURL: String = baseURL().getBaseURL() + "Patient/GetDoctorAvailableslots"
    let getLastPrescribedMedicinesURL: String = baseURL().getBaseURL() + "MasterData/GetLastPrescribedMedicines"
    let checkConsultationURL: String = baseURL().getBaseURL() + "Consultation/CheckConsultation"
    let modifyOpthaConsultationURL: String = baseURL().getBaseURL() + "Consultation/ModifyConsultation"
    let getMasterReferralSourceURL: String = baseURL().getBaseURL() + "Patient/GetMasterReferralSource"
    let getReferralSourceURL: String = baseURL().getBaseURL() + "Patient/GetReferralSource"
    //Presently This is not using
    let addUpdateMasterGeneralHistoryURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterGeneralHistory"
    //---------------
    
    let addUpdateMasterMedicalHistoryURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterMedicalHistory"
    //Presently This is not using
    let addUpdateMasterGeneralNotesURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterGeneralNotes"
    //-------------------------
    
    let addUpdateMasterChiefComplaintURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterChiefComplaint"
    
    
    //Presently This is not using
    let getMasterGeneralHistoryNotesURL: String = baseURL().getBaseURL() + "MasterData/GetMasterGeneralHistoryNotes"
    //------------------------
    
    let getMasterMedicalHistoryURL: String = baseURL().getBaseURL() + "MasterData/GetMasterMedicalHistory"
    let getMasterOcularHistoryURL: String = baseURL().getBaseURL() + "MasterData/GetMasterOccularHistory"
    let addUpdateMasterOccularHistoryURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterOccularHistory"
    
    let getMasterOcularSurgicalHistoryURL: String = baseURL().getBaseURL() + "MasterData/GetMasterOcularSurgicalHistory"
    
    let getMasterGeneralNotesURL: String = baseURL().getBaseURL() + "MasterData/GetMasterGeneralNotes"
    
    let getChiefComplaintsURL: String = baseURL().getBaseURL() + "MasterData/GetChiefComplaints"
    let getMasterChiefComplaintConditionsUS: String = baseURL().getBaseURL() + "MasterData/getMasterChiefComplaintConditionsUS"
    let sendSMSForTeleConsURL: String = baseURL().getBaseURL() + "Patient/sendTeleConsultationStartedSms"
    let addUpdatePatientInvsImgURL: String = baseURL().getBaseURL() + "MasterData/AddUpdatePatientInvImgForMobile"
    let addUpdateReferralSourceURL: String = baseURL().getBaseURL() + "Patient/AddUpdateReferralSource"
    let deletePatientInvsImageURL: String = baseURL().getBaseURL() + "MasterData/DeletePatientInvImg"
    let findingCheckValuesURL: String = baseURL().getBaseURL() + "MasterData/FindingCheckValues"
    let getAllGlassPresDropDownValuesURL: String = baseURL().getBaseURL() + "MasterData/GetAllDropdownValues"
    
    
    //https://devehnoteapi.azurewebsites.net/api/MasterData/getBranchAppointmentTypes?BranchId=3
    let getAllAppointmentTypesURL: String = baseURL().getBaseURL() + "MasterData/getBranchAppointmentTypes"
    
    
    let getPatientInsuranceDetailsByIDURL: String = baseURL().getBaseURL() + "Patient/GetPatientInsuranceDetailsById"
    let getVideoAppSessionDetailsURL: String = baseURL().getBaseURL() + "OpenTok/GetVideoAppointmentSessionDetails"
    let createOpenTokSessionTokenURL: String = baseURL().getBaseURL() + "OpenTok/CreateOpenTokSessionToken"
    let startArchiveSessionURL: String = baseURL().getBaseURL() + "OpenTok/StartArchiveSession"
    let stopArchiveSessionURL: String = baseURL().getBaseURL() + "OpenTok/StopArchiveSession"
    let getListofAllergiesURL: String = baseURL().getBaseURL() + "MasterData/getListofAllergies"
    let modifyOrgAllergyURL: String = baseURL().getBaseURL() + "MasterData/ModifyOrgAllergy"
    let getMedicalConditionSettingsURL: String = baseURL().getBaseURL() + "Patient/GetMedicalConditionSettings"
    let addUpdateOrgMedicalConditionsURL: String = baseURL().getBaseURL() + "Patient/AddUpdateOrgMedicalConditions"
    let getMasterBirthHistoryURL: String = baseURL().getBaseURL() + "MasterData/GetMasterBirthHistory"
    let addUpdateMasterBirthHistoryURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterBirthHistory"
    let getMasterFamilyHistoryURL: String = baseURL().getBaseURL() + "MasterData/GetMasterFamilyHistory"
    let addUpdateMasterFamilyHistoryURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterFamilyHistory"
    let getMasterNutritionalHistoryURL: String = baseURL().getBaseURL() + "MasterData/GetMasterNutritionalHistory"
    let addUpdateMasterNutritionalHistoryURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterNutritionalHistory"
    let getMasterImmunisationHistoryURL: String = baseURL().getBaseURL() + "MasterData/GetMasterVaccinationHistory"
    let addUpdateMasterImmunisationHistoryURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterImmunisationHistory"
    let getMasterSurgicalHistoryURL: String = baseURL().getBaseURL() + "MasterData/GetMasterSurgicalHistory"
    let getMasterSystemicHistory: String = baseURL().getBaseURL() + "MasterData/GetMasterSystemicHistory"
    let addUpdateMasterSurgicalHistoryURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterSurgicalHistory"
    let getMasterMenstrualHistoryURL: String = baseURL().getBaseURL() + "MasterData/GetMasterMenstrualHistory"
    let addUpdateMasterMenstrualHistoryURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterMenstrualHistory"
    let getMasterLifestyleHistoryURL: String = baseURL().getBaseURL() + "MasterData/GetMasterLifestyleHistory"
    let addUpdateMasterLifestyleHistoryURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterLifeStyleHistory"
    let getPatientPrerequisiteDataURL: String = baseURL().getBaseURL() + "MasterPatient/GetPatientPreRequsitesData"
    let getCovid19QuetionsURL: String = baseURL().getBaseURL() + "MasterData/GetCovid19Quetions"
    let checkAndUpdateDeviceIdURL: String = baseURL().getBaseURL() + "MasterPatient/CheckNUpdateDoctorDeviceId"
    let getMasterDiagnosisURL: String = baseURL().getBaseURL() + "MasterData/GetMasterDiagnosis"
    let getDoctorsBookedSlotsURL: String = baseURL().getBaseURL() + "Patient/GetDoctorBookedslots"
    let addUpdateMasterDiagnosisURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterDiagnosis"
    let getOrgInvestigationDataURL: String = baseURL().getBaseURL() + "Lab/GetOrgInvestigationData"
    let getMasterMedicinesForWebURL: String = baseURL().getBaseURL() + "MasterData/GetMasterMedicinesForWeb"
    let addUpdateMasterProceduresNewURL: String = baseURL().getBaseURL() + "MasterData/AddUpdateMasterProceduresNew"
    let getAllFindingValuesURL: String = baseURL().getBaseURL() + "MasterData/GetAllFindingValues"
    let addFindingValuesURL: String = baseURL().getBaseURL() + "Consultation/AddFindingValues"
    let getAllRelationsURL: String = baseURL().getBaseURL() + "/MasterData/GetAllRelations"
    let getPatientVitalsByIdURL: String = baseURL().getBaseURL() + "Patient/GetPatientVitalsById"
    let modifyPatientVitalsByIdURL: String = baseURL().getBaseURL() + "Patient/ModifyPatientVitalsById"
    let getMasterPatientsForAutocompleteURL: String = baseURL().getBaseURL() + "Patient/GetMasterPatientsForAutocomplete"
    let getMasterMadicalConditionDataURL: String = baseURL().getBaseURL() + "Patient/GetMasterMadicalConditionData"
    let getAllPatientTypeURL: String = baseURL().getBaseURL() + "MasterData/GetAllPatientType"
    let getAllBloodGroupsURL: String = baseURL().getBaseURL() + "MasterData/GetAllBloodGroups"
    
//    let getAreaSearchURL: String = baseURL().getBaseURL() + "MasterData/GetAreaSearch"
    let getAreaSearchURL: String = baseURL().getBaseURL() + "MasterData/searchLocations"
//    let getAllCitiesURL: String = baseURL().getBaseURL() + "MasterData/GetAllCities"
    let getAllCitiesURL: String = baseURL().getBaseURL() + "MasterData/getFrequentlyUsedCitiesByUserId"
    let searchCityURL: String = baseURL().getBaseURL() + "MasterData/SearchCity"
    
    let getAllMartialStatusURL: String = baseURL().getBaseURL() + "MasterData/GetAllMartialStatus"
    let getAllEducationDetailsURL: String = baseURL().getBaseURL() + "MasterData/GetAllEducationDetails"
    let getAllOccupationsURL: String = baseURL().getBaseURL() + "MasterData/GetAllOccupations"
    let getAllNationalityURL: String = baseURL().getBaseURL() + "MasterData/GetAllNationality"
    let getOrganizationInsuranceTPAURL: String = baseURL().getBaseURL() + "Insurance/GetOrganizationInsuranceTPA"
    
    let getAllDocumentTypeURL: String = baseURL().getBaseURL() + "MasterData/GetAllDocumentType"
    let getOrgBillingCategoriesURL: String = baseURL().getBaseURL() + "MasterData/getOrgBillingCategories"
    let getOrgInsTPAByIDURL: String = baseURL().getBaseURL() + "Insurance/getOrgInsuranceTpasById"
    let getInvsDetailsByPatientIDURL: String = baseURL().getBaseURL() + "Patient/GetInvestigationDtlsByPatientId"
    
    let getOrganizationTPAList: String = baseURL().getBaseURL() + "Insurance/GetOrganizationTPAList"
    let getAllRelationshipTypes: String = baseURL().getBaseURL() + "Insurance/GetAllRelationshipTypes"
    
    let getAllTitlesByParentIdURL: String = baseURL().getBaseURL() + "MasterData/GetAllTitlesByParentId"
    let checkPatientListURL: String = baseURL().getBaseURL() + "Patient/checkPatientList"
    
    let getFamilyMembersOnAutoCompleteURL: String = baseURL().getBaseURL() + "Patient/GetFamilyPatientAutoComplete"
    let addUpdatePatientInvestigationImageURL: String = baseURL().getBaseURL() + "MasterData/AddUpdatePatientInvestigationImage"
    let hsptlEquipmentURL: String = baseURL().getBaseURL() + "MasterData/GetAllHospitalEquipments"
    let getAllSurgeriesListURL: String = baseURL().getBaseURL() + "MasterData/GetAllSurgeriesList"
    let getInvsPatientListURL: String = baseURL().getBaseURL() + "Patient/getInvestigationsPatientList"
    let getCounsellorPatientListURL: String = baseURL().getBaseURL() + "Surgery/GetCounsellorPatientListByStatus"
    let getStatusWiseAllProcedureDetailsURL: String = baseURL().getBaseURL() + "Surgery/GetStatuswiseAllProcedureDetailsByPatientId"
    let addUpdateCounsStatusByTypeURL: String = baseURL().getBaseURL() + "Surgery/AddUpdateCounsellorStatusByType"
    let getAllAppsByPatientIdURL: String = baseURL().getBaseURL() + "Patient/GetAllAppointentsbyPatientId"
    let addSurgeriesToExistingAppURL: String = baseURL().getBaseURL() + "Surgery/AddSurgeriesToExistingAppointment"
    let getUserBranchAccessDetailsByIDURL: String = baseURL().getBaseURL() + "MasterData/getUserBranchAccessDetailsById"
    
    let getIPDetailsByBranchId: String = baseURL().getBaseURL() + "MasterData/GetIPDetailsByBranchId"
    
    // MARK: Department Related URL'S
    let getBranchesListByIdURL: String = baseURL().getBaseURL() + "MasterAdmins/GetBranchesListById"
    let getBrancheSubSpecializationsByIdURL: String = baseURL().getBaseURL() + "MasterAdmins/GetBranchSubSpecializationsById"
    let getAllUsersByDepartmentURL: String = baseURL().getBaseURL() + "MasterAdmins/GetAllUsersByDeptId"
    
    // MARK: Dilaton Appointments Related URL'S
    let getDilationAppointmentListURL: String = baseURL().getBaseURL() + "Patient/GetDilationAppointmentList"
    
    // MARK: Check In Related URL'S
    let updateAppointmentCheckinURL: String = baseURL().getBaseURL() + "Patient/UpdateAppointmentCheckin"
    
    // MARK: GetPatientDynamicStatusForMobile
    let getPatientDynamicStatusForMobileURL: String = baseURL().getBaseURL() + "Patient/GetPatientDynamicStatusForMobile"
    
    // MARK: GetAllAppointmentList for Receptionist in patient Dynamic
    let getAllAppointmentListForRecptionURL: String = baseURL().getBaseURL() + "Patient/GetAllAppointmentList"
    
    // MARK: GetAllAppointmentList for SelRoomList in patient Dynamic
    let getPatientDynamicStatusListURL: String = baseURL().getBaseURL() + "Patient/GetPatientDynamicStatusList"
    
    // MARK: getAllWaitingRoomTypeURL for all room list id's and names
    let getAllWaitingRoomTypeURL: String = baseURL().getBaseURL() + "MasterData/GetAllWaitingRoomType"
    
    // After check in room type lists
    let getWaitingRoomListURL: String = baseURL().getBaseURL() + "Setting/GetWaitingRoomList"
    
    // After selecting room from list in pop up after done btn action we need to use this
    let addUpdatePatientDynamicStatusURL: String = baseURL().getBaseURL() + "Patient/AddUpdatePatientDynamicStatus"
    
    // For Checkout Patient
    let getCheckedOutPatientsListURL: String = baseURL().getBaseURL() + "Patient/GetCheckedOutPatientsList"
    
    // For Active list
    let getPatientDynamicStatusActiveListURL: String = baseURL().getBaseURL() + "Patient/GetPatientDynamicStatusActiveList"
    
    // For Track Patient
    let getPatientDynamicStatusByIdURL: String = baseURL().getBaseURL() + "Patient/GetPatientDynamicStatusById"
    
    // For OrganizationSettings
    let getOrganizationSettingsURL: String = baseURL().getBaseURL() + "Setting/GetOrganizationSettings"
        
    // For Consumables in OT
    let getPatientSurgeryConsumableDetail: String = baseURL().getBaseURL() + "Surgery/GetPatientSurgeryConsumableDetail"
    let getSurgeryBillingPackageItemDetailsById: String = baseURL().getBaseURL() + "Surgery/GetSurgeryBillingPackageItemDetailsById"
    let getConsumableCategoryList: String = baseURL().getBaseURL() + "HInventory/CategoryList"
    let getSearchHospitalInventory: String = baseURL().getBaseURL() + "Surgery/SearchHospitalInventory"
    let searchDepartmentWiseStock: String = baseURL().getBaseURL() + "Inventory/SearchDepartmentWiseStock"
    
    let modifyPatientSurgeryConsumtion:String = baseURL().getBaseURL() + "Surgery/ModifyPatientSurgeryConsumtion"
    
    //New Services for US
    
    let getAllMasterConsultationData:String = baseURL().getBaseURL() + "MasterData/GetAllMasterConsultationData"
    let getDefaultReasonsForDoctors: String = baseURL().getBaseURL() + "Setting/GetDefaultReasonsForDoctors"
    let getOrganizationInsurancePayorsList: String = baseURL().getBaseURL() + "Insurance/GetOrganizationInsurancePayorsList"
    let getOrganizationPayorPlans: String = baseURL().getBaseURL() + "Insurance/GetOrganizationPayorPlans"
    let modifyMasterPatientInsuranceDetails: String = baseURL().getBaseURL() + "Patient/ModifyPatientInsuranceDetails"
    let getLocationByZipCode: String = baseURL().getBaseURL() + "masterdata/GetLocationsByZipCode"
    let getCountyByZipCode: String = baseURL().getBaseURL() + "masterdata/GetCountyByZipCodes"
    let getAllCountriesURL: String = baseURL().getBaseURL() + "MasterData/GetAllCountries"
    let getAllStatesURL: String = baseURL().getBaseURL() + "MasterData/GetStatesById"
    let getAllAreasURL: String = baseURL().getBaseURL() + "MasterData/searchLocations"
    let addUpdatePatientAddressDeatils: String = baseURL().getBaseURL() + "Patient/AddUpdatePatientAddressDeatils"
    let getPatientRelatedMasterData: String = baseURL().getBaseURL() + "MasterData/GetPatientRelatedMasterData"
    let addUpdatePatientDemographicsDetails: String = baseURL().getBaseURL() + "Patient/AddUpdatePatientDemographicsDetails"
//    let addUpdateDesignatedDetails: String = baseURL().getBaseURL() + "Patient/AddUpdateDesignatedDetails"
    let addUpdateDesignatedDetails: String = baseURL().getBaseURL() + "Patient/AddUpdateDesignatedDetailsnew"
    let getMasterInsuranceIdentifier: String = baseURL().getBaseURL() + "MasterData/GetMasterInsuranceIdentifier"
    let getPatient: String = baseURL().getBaseURL() + "Patient/GetPatient"
    let getMasterFunctionalstatus: String = baseURL().getBaseURL() + "MasterData/GetMasterFunctionalstatus"
    let addUpdatePatientFamilyDetails: String = baseURL().getBaseURL() + "Patient/AddUpdatePatientFamilyDetails"
    let getReferalPCPDoctors: String = baseURL().getBaseURL() + "CareTeam/GetReferalPCPDoctors"
    let getParticularTimeSlotDetailsById: String = baseURL().getBaseURL() + "Setting/getParticularTimeSlotDetailsById"
    let getApprovedSurgeryAppointments: String = baseURL().getBaseURL() + "Patient/GetApprovedSurgeryAppointments"
    
    //Get Doctor Available Dates
//    let getDocAvailableDates: String = baseURL().getBaseURL() +
//    "Patient/GetDocAvailableDates"
    let getDocAvailableDates: String = baseURL().getBaseURL() + "Patient/GetDoctorSlotsByVisitReasons"
    
    let getAdditionalAppointmentDtlsbyId: String = baseURL().getBaseURL() +  "Patient/GetAdditionalAppointmentDtlsbyId"
    let getAppointmentDoctorsCountbyBranch: String = baseURL().getBaseURL() +  "Admin/GetAppointmentDoctorsCountbyBranch"
    let deleteDesignatedDocumentDetailsById: String = baseURL().getBaseURL() +  "Patient/DeleteDesignatedDocumentDetailsById"
    let modifyAppointmentNotesById: String = baseURL().getBaseURL() +  "Patient/ModifyAppointmentNotesById"
    let getDoctorAvailableAppointment: String = baseURL().getBaseURL() + "Patient/GetDoctorAvailableAppointment"
    let addUpdateAppointmentTrackerDetails: String = baseURL().getBaseURL() + "Patient/AddUpdateAppointmentTrackerDetails"
    let getVisitReasonAvailableAppointments: String = baseURL().getBaseURL() + "Patient/GetVisitReasonAvailableAppointments"
    let getVisitReasonBasedAppointmentCounts: String = baseURL().getBaseURL() + "Consultation/GetVisitReasonBasedAppointmentCounts"
    let getLatestTrackerStatusById: String = baseURL().getBaseURL() + "Patient/GetLatestTrackerStatusById"
    let deletePatientInsuranceDetails: String = baseURL().getBaseURL() + "Patient/DeletePatientInsuranceDetails"

    //ASC
    
    let getAllASCappointmentList: String = baseURL().getBaseURL() + "MasterData/GetAllAscAppointmentsList"
    let getPreOpChartData: String = baseURL().getBaseURL() + "Surgery/GetPreOpChartData"
    let getOrganizationPreOpMedications: String = baseURL().getBaseURL() + "Surgery/GetOrganizationPreOpMedications"
    let getOrganizationASCCheckListData: String = baseURL().getBaseURL() + "Surgery/GetOrganizationASCCheckListData"
    let addUpdatePreOpChartData: String = baseURL().getBaseURL() + "Surgery/AddUpdatePreOpChartData"
    let addUpdatePreOpAndDialationMedications: String = baseURL().getBaseURL() + "Surgery/AddUpdatePreOpAndDialationMedications"
    let getOrganizationMedications: String = baseURL().getBaseURL() + "Patient/GetOrganizationMedications"
}

class APIRequest {
    static let shared = APIManager()
    
    class func loginAPI(params: [String: Any]?, success:@escaping (LoginResponse) -> Void, failure:@escaping (Error) -> Void) {
        RestClient.requestPOSTURLObject(
            URLS().loginURL,
            params: params,
            responseType: LoginResponse.self,
            success: { response in
                success(response)
            },
            failure: { error in
                failure(error)
            }
        )
    }
    
    class func getBranchesListByIdAPI(params: [String: Any], success: @escaping(BranchListData) -> Void, failure: @escaping (Error) -> Void) {
        RestClient.requestGETURLObject(URLS().getBranchesListByIdURL, params: params, responseType: BranchListData.self) { response in
            success(response)
        } failure: { error in
            failure(error)
        }

    }
    
    class func getUserConsultationitemsAPI(params: [String: Any]?, success: @escaping(GetUserConsultationitemsResponse) -> Void, failure: @escaping(Error) -> Void) {
        RestClient.requestGETURL(URLS().getUserConsultationitemsURL, params: params, responseType: GetUserConsultationitemsResponse.self) { response in
            success(response)
        } failure: { error in
            failure(error)
        }
    }
    
    class func getAllWaitingRoomTypeAPI(params: [String: Any]?,success: @escaping(GetAllWaitingRoomTypeModel) -> Void, failure: @escaping(Error) -> Void) {
        RestClient.requestGETURL(URLS().getAllWaitingRoomTypeURL, params: params, responseType: GetAllWaitingRoomTypeModel.self) { response in
            success(response)
        } failure: { error in
            failure(error)
        }
    }
}

