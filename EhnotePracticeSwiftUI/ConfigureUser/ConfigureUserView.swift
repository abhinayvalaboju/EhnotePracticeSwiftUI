//
//  ConfigureUserView.swift
//  EhnotePracticeSwiftUI
//
//  Created by Abhinay Chary on 3/27/25.
//

import SwiftUI

struct ConfigureUserView: View {
    
    @State private var parentOrganization: String = ""
    @State private var userName: String = ""
    @State private var selectedSubOrganization:UserSubOrganization? = nil
    private var selectedSubOrgNameBinding: Binding<String> {
        Binding<String>(
            get: {
                selectedSubOrganization?.subOrgName ?? "Select"
            },
            set: { newValue in
                if let found = subOrgArr.first(where: { $0.subOrgName == newValue }) {
                    selectedSubOrganization = found
                }
            }
        )
    }
    @State private var selectedBranch:UserAddress? = nil
    private var selectedBranchNameBinding: Binding<String> {
        Binding<String>(
            get: {
                selectedBranch?.clinicName ?? "Select"
            },
            set: { newValue in
                if let found = branchesArr.first(where: { $0.clinicName == newValue }) {
                    selectedBranch = found
                }
            }
        )
    }
    @State private var sheetPresented = false
    @State private var subOrgSelected = false
    @State private var branchSelected = false
    
    var subOrgArr: [UserSubOrganization] = Constants.globalLoginResponse?.userSubOrganization ?? []
   @State var branchesArr: [UserAddress] = []
    
    
    @State var selectedBranchData:UserAddress?
    
    var body: some View {
        CustomNavBar(title: "Config User",showActionBtn: (selectedSubOrganization?.subOrgName ?? "" != "Select" && selectedBranch?.clinicName ?? "" != "Select"),actionTitle: (selectedSubOrganization?.subOrgName ?? "" != "Select" && selectedBranch?.clinicName ?? "" != "Select") ? "Save" : "") {
            
        }
            ZStack {
                VStack{
                    // Profile Section
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 10){
                            Image("Organization_Icon") // Placeholder profile icon
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .foregroundColor(.gray)
                                .padding(5)
                            
                            VStack(alignment:.leading){
                                
                                Text($parentOrganization.wrappedValue)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                Text($userName.wrappedValue)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                    }
                    .frame(height:80)
                    .background(Color.white)
                    
                    // Dropdown Section
                    VStack(alignment: .leading, spacing: 16) {
                        DropdownView(title: "Sub Organization", icon: "",img: "DBFilter_SubOrg", selection: selectedSubOrgNameBinding,subOrgSelected: $subOrgSelected,branchSelected: $branchSelected,sheetPresented: $sheetPresented)
//                            .onTapGesture {
//                                withAnimation(.spring()) {
//                                    sheetPresented.toggle()
//                                    branchSelected = false
//                                    subOrgSelected = true
//                                }
//                            }
                        DropdownView(title: "Branch", icon: "building.2",img: "DBFilter_Branch", selection: selectedBranchNameBinding,subOrgSelected: $subOrgSelected,branchSelected: $branchSelected,sheetPresented: $sheetPresented)
//                            .onTapGesture {
//                                withAnimation(.spring()) {
//                                    sheetPresented.toggle()
//                                    branchSelected = true
//                                    subOrgSelected = false
//                                }
//                            }
                    }
                    .padding(10)
                    Spacer()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray6))
            .sheet(isPresented: $sheetPresented) {
                if subOrgSelected{
                    SheetView(sheetPresented:$sheetPresented, title: "Sub Organization", subOrganization: subOrgArr, branchesArr: [], selectedValue: selectedSubOrgNameBinding,selectedSubOrganization:$selectedSubOrganization,selectedBranch:$selectedBranch)
                }else if branchSelected{
                    SheetView(sheetPresented:$sheetPresented,title: "Branches", subOrganization: [], branchesArr: branchesArr, selectedValue: selectedBranchNameBinding,selectedSubOrganization:$selectedSubOrganization,selectedBranch:$selectedBranch)
                }
            }
        
        .onAppear {
            setupInitialData()
        }
    }
    
    func setupInitialData() {
        parentOrganization = Constants.globalLoginResponse?.userAddress?[0].parentOrganizationName ?? ""
        userName = Constants.globalLoginResponse?.user?[0].fullName ?? ""
        
        if(subOrgArr.count == 1){
//            selectedSubOrgNameBinding = subOrgArr[0].subOrgName ?? ""
            let subOrgID: Int = Constants.globalLoginResponse?.userSubOrganization?[0].subOrgID ?? 0
            Constants.selSubOrgID = subOrgID
            UserDefaults.standard.setValue(subOrgID, forKey: Constants.selectedSubOrganizationID)
            
            self.branchesArr = Constants.globalLoginResponse?.userAddress?.filter({ $0.subOrgID == Constants.selSubOrgID }) ?? []
        }
    }
}



// Dropdown View Component
struct DropdownView: View {
    var title: String
    var icon: String
    var img:String
    @Binding var selection: String
    @Binding var subOrgSelected: Bool
    @Binding var branchSelected: Bool
    @Binding var sheetPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            HStack {
                Image(img)
                    .foregroundColor(.gray)
                
                Text(selection)
                    .foregroundColor((selection == "Select") ? .gray : .black)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(height: 40)
            .background(Color.white)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
        .onTapGesture {
            sheetPresented = true
            if title == "Sub Organization" {
                subOrgSelected = true
                branchSelected = false
            } else if title == "Branch" {
                subOrgSelected = false
                branchSelected = true
            }
        }
    }
}

struct SheetView: View {
    @Binding var sheetPresented:Bool
    var title: String = "asdasd"
    var subOrganization: [UserSubOrganization]
    var branchesArr: [UserAddress]
    var test = ["Test 1","Test 2","Test 3"]
    
    @Binding var selectedValue: String
//    @Binding var selectedSubOrganization: String
//    @Binding var selectedBranch: String
    
    @Binding var selectedSubOrganization:UserSubOrganization?
    @Binding var selectedBranch:UserAddress?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text(title)
            .font(.headline)
            .frame(width:Constants.screenWidth,height:65)
            .foregroundColor(Color.white)
            .background(Color(red: 24/255, green: 63/255, blue: 60/255).ignoresSafeArea())
        if !subOrganization.isEmpty {
            List(subOrganization, id: \.subOrgID) { item in
                Text(item.subOrgName ?? "N/A")
                    .onTapGesture {
                        selectedValue = item.subOrgName ?? ""
                        sheetPresented = false
                    }
            }
            .listStyle(PlainListStyle())
        } else if !branchesArr.isEmpty {
            List(branchesArr, id: \.userBranchID) { item in
                Text(item.clinicName ?? "N/A")
                    .onTapGesture {
                        selectedValue = item.clinicName ?? ""
                        sheetPresented = false
                        let roleID: Int = item.roleID ?? 0
                        
                        if(roleID == 1 || roleID == 2 || roleID == 4 || roleID == 10 || roleID == 11 || roleID == 15 || roleID == 30 || roleID == 18 || roleID == 48 || roleID == 19 || roleID == 20 || roleID == 21 || roleID == 43 || roleID == 54 || roleID == 62 || roleID == 63 || roleID == 64 || roleID == 65 || roleID == 66 || roleID == 67 || roleID == 68 || roleID == 69 || roleID == 70 || roleID == 71 || roleID == 16) {
                            let hospID: Int = item.extDetails?.hospitalInfo?.hospitalID ?? 0
                            let branch: String = item.clinicName ?? ""
                            let hospCode: String = item.extDetails?.hospitalInfo?.hospitalCode ?? ""
                            let hospState = item.stateName
                            let hospCountry = item.countryName
                            
                            let hospStateID = item.stateID
                            let hospCountryID = item.countryID
                            
                            Constants.selHospID = hospID
                            Constants.selHospName = branch
                            Constants.selHospCode = hospCode
                            Constants.selHospCountry = hospCountry
                            Constants.selHospState = hospState
                            
                            Constants.selHospStateID = hospStateID
                            Constants.selHospCountryID = hospCountryID
                            
                            UserDefaults.standard.set(hospID, forKey: Constants.selectedHospitalID)
                            UserDefaults.standard.setValue(branch, forKey: Constants.selectedBranchName)
                            UserDefaults.standard.setValue(hospCode, forKey: Constants.selectedHsptlCode)
                            UserDefaults.standard.setValue(hospState, forKey: Constants.selectedHospState)
                            UserDefaults.standard.setValue(hospCountry, forKey: Constants.selectedHospCountry)
                            
                            UserDefaults.standard.set(hospStateID, forKey: Constants.selectedHospStateID)
                            UserDefaults.standard.set(hospCountryID, forKey: Constants.selectedHospCountryID)
                            
                            self.selectedBranch = item
//                            branchTF.text = branchesArr[index].clinicName ?? ""
                            
                            UserDefaults.standard.set(roleID, forKey: Constants.selectedRoleID)
                            UserDefaults.standard.setValue(item.roleName ?? "", forKey: Constants.selectedRoleName)
                            
                        } else {
//                            Constants.showAlertView(alertTitle: "Warning!",
//                                                    alertMessage: "You are not authorized to access",
//                                                    issingle: true,
//                                                    viewController: self)
                        }
                    }
            }
            .listStyle(PlainListStyle())
        } else {
            Spacer()
            Text("No data available")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
        }
        
    }
}

#Preview {
    ConfigureUserView()
}
