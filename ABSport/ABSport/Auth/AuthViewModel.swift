//
//  AuthViewModel.swift
//  ABSport
//
//  Created by mac on 19.05.2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import Combine

protocol AutentificationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var curentUser: FirebaseUser?
    
    //private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signInApp(withEmail email: String, password: String) async throws {
        do {
            print("Attempting to sign in...")
            
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
            print("Sign in successful: \(result.user.uid)")
            
            self.userSession = result.user  // don't work !!!
            
            if let userSession = self.userSession {
                        print("User session set: \(userSession.uid)")
                    } else {
                        print("Failed to set user session")
                    }
            await fetchUser()
        } catch {
            print("DEBUG: Failed to login with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email,
                                                        password: password)
            self.userSession = result.user
            print("Registr successful: \(result.user.uid)")
            let user = FirebaseUser(id: result.user.uid,
                                    fullName: fullName,
                                    email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("allUsers").document(user.id).setData(encodedUser)
            
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.curentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccountc() async {
        guard let user = Auth.auth().currentUser else {
            print("DEBUG: No user is signed in.")
            return }
        
        do {
            let userDoc = Firestore.firestore().collection("allUsers").document(user.uid)
            try await userDoc.delete()
            
            try await user.delete()
            
            self.userSession = nil
            self.curentUser = nil
            
            print("DEBUG: User account deleted successfully.")
        } catch {
            print("DEBUG: Failed to delete account with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("allUsers").document(uid).getDocument() else { return }
        self.curentUser = try? snapshot.data(as: FirebaseUser.self)
        
        ReservationManager.shared.userId = uid
        
        print("DEBUG: Curent user is: \(self.curentUser)")
    }
}
