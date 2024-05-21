//
//  ReservationManager.swift
//  SwiftUIPlayground
//
//  Created by Александр Бобрун on 13.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// TEMP (JUST MOCK)
final class ReservationManager {
    
    static let shared = ReservationManager()
    
    var userReservationsCache: [String:[Reservation]] = [:] // dayMonth : [user reservations with this day]
    var allTrainersCache: [Trainer] = []
    
    private let dateFormatter = DateFormaterManagerImpl()
    
    private let database = Firestore.firestore()
    
    private init() {
    }
    
    func allReservations(complition: @escaping ([String: [Reservation]]) -> Void ) {
        // MARK: to fetch
        fetchTrainerReservations(withId: "1", forDay: "2", complition: { _ in print("done")})
        DispatchQueue.main.async {
            let fetchedUser = UserManager.shared.user
            var reservationDictionary: [String: [Reservation]] = [:]
            for item in fetchedUser.reservations {
                reservationDictionary[self.dateFormatter.formate(date: item.startDate,
                                                                 toType: .dayMonthYear), default: [item]].append(item)
            }
            complition(reservationDictionary)
        }
    }
    
    /// function of fetching all trainers
    func fetchAllTrainers(complition: @escaping (Result<[Trainer], Error>) -> Void ) {
        
        guard allTrainersCache.isEmpty else {
            complition(.success(allTrainersCache))
            return
        }
        
        database.collection("allTrainers").addSnapshotListener{ [weak self] (documents, error) in
            guard let documents = documents else {
                print("Error fetching documents: \(String(describing: error)) or documents doesn't exist")
                return
            }
            var allTrainers: [Trainer] = []
            documents.documents.forEach { (document) in
                let dataDescription = document.data()
                let trainer = Trainer(id: dataDescription["id"] as? String ?? "",
                                      name: dataDescription["name"] as? String ?? "",
                                      imageURL: dataDescription["imageURL"] as? String ?? "",
                                      reservationTypes: dataDescription["reservationTypes"] as? [String] ?? [])
                allTrainers.append(trainer)
            }
            complition(.success(allTrainers))
            self?.allTrainersCache = allTrainers
        }
    }
    
    /// function of fetching all reservation of current trainer for current day
    func fetchTrainerReservations(withId trainerId: String, forDay day: String, complition: @escaping (Result<[Reservation], Error>) -> Void) {
        database.collection("days")
            .document(day)
            .collection("trainers")
            .document(trainerId)
            .collection("reservations").addSnapshotListener{ [weak self] (documents, error) in
            guard let documents = documents else {
                print("Error fetching documents: \(String(describing: error)) or documents doesn't exist")
                return
            }
            
            documents.documents.forEach { (document) in
                let dataDescription = document.data()
                let trainer = dataDescription["id"] as? String ?? ""
                print(trainer)
            }
        }
    }
    
    /// function of fetching all reservation of user for current day
    func fetchUserReservations(withId userId: String, forDay day: String, complition: @escaping (Result<[Reservation], Error>) -> Void) {
        database.collection("days")
            .document(day)
            .collection("users")
            .document(userId)
            .collection("reservations").addSnapshotListener{ [weak self] (documents, error) in
            guard let documents = documents else {
                print("Error fetching documents: \(String(describing: error)) or documents doesn't exist")
                return
            }
            
            documents.documents.forEach { (document) in
                let dataDescription = document.data()
                
                let type: ReservationType = switch dataDescription["reservationType"] as? String ?? "" {
                case ReservationType.bicycleTraining.rawValue:
                        .bicycleTraining
                case ReservationType.equipmentReservation.rawValue:
                        .equipmentReservation
                case ReservationType.poolTraining.rawValue:
                        .poolTraining
                case ReservationType.runningTraining.rawValue:
                        .runningTraining
                default:
                        .unknown
                }
                
                let reservation = Reservation(id: dataDescription["id"] as? String ?? "",
                                              type: type,
                                              isIndividual: dataDescription["isIndividual"] as? Bool ?? true,
                                              numberOfFreeSlots: dataDescription["numberOfFreeSlots"] as? Int ?? 0,
                                              trainerName: dataDescription["trainerName"] as? String ?? nil,
                                              startDate: dataDescription["startDate"] as? Date ?? Date(),
                                              endDate: dataDescription["endDate"] as? Date ?? Date())
                print(reservation)
            }
        }
    }
    
    func sendReservation(forDay: String, reservation: FirebaseReservation) {
        DispatchQueue.main.async {
            do {
                try self.database.collection("test").document("test1").setData(from: reservation)
            } catch {
                print("Error adding messages to Firestore: \(error.localizedDescription)")
            }
        }
    }
}
