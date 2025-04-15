//
//  LoginView.swift
//  EhnotePracticeSwiftUI
//
//  Created by Abhinay Chary on 3/24/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showConfigureUserView = false // Changed from shouldNavigateToConfigureUser
    @StateObject private var loginVM = LoginViewModel()
    @State private var shouldNavigateToConfigureUser = false
    
    var body: some View {
        ZStack {
            Image("Splash_Dots")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Logo and header
                Image("EhnoteWhiteLogo")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding()
                Image("LoginHeaderLogo")
                    .resizable()
                    .frame(width: 180, height: 60)
                
                // Form
                VStack(spacing: 16) {
                    // Email field
                    TextField("Email", text: $email)
                        .padding()
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(5)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                    
                    // Password field with show/hide toggle
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Text(isPasswordVisible ? "HIDE" : "SHOW")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                        }
                    }
                    .padding()
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    
                    // Login Button
                    Button(action: {
                        if email.isEmpty || password.isEmpty {
                            alertMessage = "Please enter both email and password"
                            showAlert = true
                        } else if !Constants.isValidEmail(email: email) {
                            alertMessage = "Please enter a valid email address"
                            showAlert = true
                        } else {
                            login()
                        }
                    }) {
                        if loginVM.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("LOGIN")
                                .frame(maxWidth: .infinity, minHeight: 50)
                        }
                    }
                    .background(Color(red: 24/255, green: 63/255, blue: 60/255))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .cornerRadius(5)
                    .disabled(loginVM.isLoading)
                    
                    Spacer()
                    
                    // Help button
                    Button(action: {
                        // Help action
                    }) {
                        HStack(spacing: 5) {
                            Text("Need Help")
                            Image(systemName: "questionmark.circle")
                        }
                        .foregroundColor(Color(red: 24/255, green: 63/255, blue: 60/255))
                    }
                    .padding(.top, 20)
                }
                .padding()
                .background(Color.white)
            }
        }
        .background(Color(red: 24/255, green: 63/255, blue: 60/255).ignoresSafeArea())
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationDestination(isPresented: $shouldNavigateToConfigureUser) {
                   ConfigureUserView()
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
               }
    }
    
    func login() {
        loginVM.loginUser(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("Login API Success: \(response)")
                    if (response.status != nil) {
                        print("Login valid sucess")
                        navigateToAppointments(data: response)
                    } else {
                        print("Login failed with message: \(response.message ?? "No error message")")
                        alertMessage = response.message ?? ""
                        showAlert = true
                    }
                    
                case .failure(let error):
                    print("Login API Error: \(error.localizedDescription)")
                    alertMessage = error.localizedDescription
                    showAlert = true
                }
            }
        }
    }
    
    func navigateToAppointments(data: LoginResponse?) {
        if data == nil {
            alertMessage = "Invalid response data"
            showAlert = true
            return
        }
        
        if let userSubOrgs = data?.userSubOrganization,
           let userAddresses = data?.userAddress,
           userSubOrgs.count == 1,
           userAddresses.count == 1 {
            
            if let roleID = userAddresses[0].roleID {
                let authorizedRoles: Set<Int> = [1, 2, 4, 10, 11, 15, 16, 18, 19, 21, 43, 48, 62, 63, 64, 65, 66, 67, 68, 69, 71, 30, 8, 25, 73, 38]
                
                if authorizedRoles.contains(roleID) {
                    let subOrgID = userSubOrgs[0].subOrgID ?? 0
                    let hospID = userAddresses[0].extDetails?.hospitalInfo?.hospitalID ?? 0
                    let branch = userAddresses[0].clinicName ?? ""
                    let hospCode = userAddresses[0].extDetails?.hospitalInfo?.hospitalCode ?? ""
                    let hospState = userAddresses[0].stateName
                    let hospCountry = userAddresses[0].countryName
                    let hospStateID = userAddresses[0].stateID
                    let hospCountryID = userAddresses[0].countryID
                    
                    Constants.selSubOrgID = subOrgID
                    Constants.selHospID = hospID
                    Constants.selHospName = branch
                    Constants.selHospCode = hospCode
                    Constants.selHospState = hospState
                    Constants.selHospCountry = hospCountry
                    Constants.selHospStateID = hospStateID
                    Constants.selHospCountryID = hospCountryID
                    
                    UserDefaults.standard.set(subOrgID, forKey: Constants.selectedSubOrganizationID)
                    UserDefaults.standard.set(hospID, forKey: Constants.selectedHospitalID)
                    UserDefaults.standard.set(branch, forKey: Constants.selectedBranchName)
                    UserDefaults.standard.set(hospCode, forKey: Constants.selectedHsptlCode)
                    UserDefaults.standard.set(roleID, forKey: Constants.selectedRoleID)
                    UserDefaults.standard.set(userAddresses[0].roleName ?? "", forKey: Constants.selectedRoleName)
                    UserDefaults.standard.set(hospState, forKey: Constants.selectedHospState)
                    UserDefaults.standard.set(hospCountry, forKey: Constants.selectedHospCountry)
                    UserDefaults.standard.set(hospStateID, forKey: Constants.selectedHospStateID)
                    UserDefaults.standard.set(hospCountryID, forKey: Constants.selectedHospCountryID)
                    
                    fetchBranches(userSubOrgs: userSubOrgs)
                    loginVM.getUserConsultationitems(userId: Constants.globalLoginResponse?.user?[0].doctorID ?? 0, hospitalId: (Constants.selHospID ?? 0))
                    loginVM.getAllWaitingRoomList()
                   
                } else {
                    alertMessage = "You are not authorized to access"
                    showAlert = true
                }
            }
        } else {
            shouldNavigateToConfigureUser = true
        }
    }
    
    func fetchBranches(userSubOrgs: [UserSubOrganization]) {
        if userSubOrgs.isEmpty {
            print("fetchBranches failed - empty userSubOrgs")
            alertMessage = "No suborganizations available"
            showAlert = true
            return
        }
        
        if let subOrgID = userSubOrgs[0].subOrgID {
            print("Starting branches fetch for subOrgID: \(subOrgID)")
            loginVM.getBranchesListByID(subOrgID: subOrgID) {  result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let branchData):
                        print("Branches fetch success - data count: \(branchData.rows?.count ?? 0)")
                        self.processBranchData(branchData: branchData)
                    case .failure(let error):
                        print("Branches fetch failed: \(error.localizedDescription)")
                        self.alertMessage = error.localizedDescription
                        self.showAlert = true
                    }
                }
            }
        } else {
            print("fetchBranches failed - no subOrgID found")
            alertMessage = "No suborganization ID found"
            showAlert = true
        }
    }
    
    func processBranchData(branchData: BranchListData?) {
        if branchData == nil {
            print("processBranchData failed - nil data")
            alertMessage = "No branch data received"
            showAlert = true
            return
        }
        
        print("Processing branch data with \(branchData!.rows?.count ?? 0) items")
        Constants.globalHospitalList = branchData!.rows
        
        if let addresses = Constants.globalLoginResponse?.userAddress {
            let filteredAddresses = addresses.filter { $0.subOrgID == Constants.selSubOrgID }
            
            if let hospitalList = Constants.globalHospitalList {
                for index in 0..<hospitalList.count {
                    for addr in filteredAddresses {
                        if addr.extDetails?.hospitalInfo?.hospitalID ?? 0 == hospitalList[index].hospitalInfo?.hospitalDetails?.branchID {
                            Constants.globalHospitalList?[index].isAssignedHospital = true
                        }
                    }
                }
            }
        }
        UserDefaults.standard.set(true, forKey: Constants.loginStatus)
        UserDefaults.standard.set(email, forKey: Constants.emailID)
        UserDefaults.standard.set(password, forKey: Constants.password)
    }
}

#Preview {
    LoginView()
}
