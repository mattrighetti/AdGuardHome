//
//  AccountSetupViewController.swift
//  AdGuardHome
//
//  Created by Matt on 05/12/2022.
//

import SwiftUI

struct AccountSetupViewController: View {
    @Environment(\.dismiss) var dismiss

    @State private var showError = false
    @AppStorage("accountName") private var name: String = ""
    @AppStorage("accountPassword") private var password: String = ""
    @AppStorage("ipAddr") private var ipAddr: String = ""

    var completion: (() -> Void)? = nil

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("IP Address", text: $ipAddr)
                        .textInputAutocapitalization(.never)
                    TextField("Username", text: $name)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $password)
                }

                Button("Add", action: {
                    guard validateFields() else { showError.toggle(); return }
                    completion?()
                    dismiss()
                })
            }
            .navigationTitle("Account Setup")
            .alert("Invalid data", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            }
        }
    }

    private func validateFields() -> Bool {
        !name.isEmpty && !password.isEmpty && !ipAddr.isEmpty
    }

    private func makeTestCall() {
        // TODO test call to ip address to verify auth
    }

}

struct AccountSetupViewController_Previews: PreviewProvider {
    static var previews: some View {
        AccountSetupViewController()
    }
}
