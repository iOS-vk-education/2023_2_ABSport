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
    
    var userReservationsCache: [String: [Reservation]] = [:] // dayMonth : [user reservations with this day]
    var allTrainersCache: [Trainer] = []
    var userId = "testUserId 103FC930-40D6-4B35-87DB-FD6749CDC305"
    
    private let dateFormatter = DateFormaterManagerImpl()
    
    private let database = Firestore.firestore()
    
    private init() {
    }
    
    func allReservations(complition: @escaping ([String: [Reservation]]) -> Void ) {
        // MARK: to fetch
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
        
        database.collection("allTrainers").addSnapshotListener { [weak self] (documents, error) in
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
            .collection("reservations").addSnapshotListener { (documents, error) in
            guard let documents = documents else {
                print("Error fetching documents: \(String(describing: error)) or documents doesn't exist")
                return
            }
            
            documents.documents.forEach { (document) in
                let dataDescription = document.data()
                
                let stringType = dataDescription["type"] as? String ?? ""
                let type: ReservationType = switch stringType {
                case _ where stringType == ReservationType.bicycleTraining.rawValue:
                        .bicycleTraining
                case _ where stringType == ReservationType.equipmentReservation.rawValue:
                        .equipmentReservation
                case _ where stringType == ReservationType.poolTraining.rawValue:
                        .poolTraining
                case _ where stringType == ReservationType.runningTraining.rawValue:
                        .runningTraining
                default:
                        .unknown
                }
                
                let reservation = Reservation(id: dataDescription["id"] as? String ?? "",
                                              type: type,
                                              isIndividual: dataDescription["isIndividual"] as? Bool ?? true,
                                              numberOfFreeSlots: dataDescription["numberOfFreeSlots"] as? Int ?? 0,
                                              trainerName: dataDescription["trainerName"] as? String ?? nil,
                                              trainerId: dataDescription["trainerId"] as? String ?? nil,
                                              startDate: dataDescription["startDate"] as? Date ?? Date(),
                                              endDate: dataDescription["endDate"] as? Date ?? Date())
            }
        }
    }
    
    /// function of sending reservation of current trainer and user for current day
    func sendReservations(forDay day: String, reservation: Reservation) {
        
        let firebaseReservation = FirebaseReservation(userId: userId,
                                                      reservation: reservation)
        do {
            try self.database.collection("days")
                .document(day)
                .collection("trainers")
                .document(firebaseReservation.trainerId)
                .collection("reservations").document(firebaseReservation.id).setData(from: firebaseReservation)
            
            try self.database.collection("days")
                .document(day)
                .collection("users")
                .document(firebaseReservation.userId)
                .collection("reservations").document(firebaseReservation.id).setData(from: firebaseReservation)
        } catch {
            print("Error adding messages to Firestore: \(error.localizedDescription)")
        }
    }
    
    /// function of deleting current reservation of current trainer and user for current day
    func deleteReservation(forDay day: String, reservation: Reservation) {
        let firebaseReservation = FirebaseReservation(userId: "testUserId 103FC930-40D6-4B35-87DB-FD6749CDC305",
                                                      reservation: reservation)
        
        self.database.collection("days")
            .document(day)
            .collection("trainers")
            .document(firebaseReservation.trainerId)
            .collection("reservations").document(firebaseReservation.id).delete { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        
        self.database.collection("days")
            .document(day)
            .collection("users")
            .document(firebaseReservation.userId)
            .collection("reservations").document(firebaseReservation.id).delete { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
    }
    
    /// function of fetching all reservation of user for current day
    func fetchUserReservations(withId userId: String, forDay day: String, complition: @escaping (Result<[Reservation], Error>) -> Void) {
        database.collection("days")
            .document(day)
            .collection("users")
            .document(userId)
            .collection("reservations").addSnapshotListener { (documents, error) in
                guard let documents = documents else {
                    print("Error fetching documents: \(String(describing: error)) or documents doesn't exist")
                    return
                }
                
                var reservations: [Reservation] = []
                
                documents.documents.forEach { (document) in
                    let dataDescription = document.data()
                    
                    let stringType = dataDescription["type"] as? String ?? ""
                    let type: ReservationType = switch stringType {
                    case _ where stringType == ReservationType.bicycleTraining.rawValue:
                            .bicycleTraining
                    case _ where stringType == ReservationType.equipmentReservation.rawValue:
                            .equipmentReservation
                    case _ where stringType == ReservationType.poolTraining.rawValue:
                            .poolTraining
                    case _ where stringType == ReservationType.runningTraining.rawValue:
                            .runningTraining
                    default:
                            .unknown
                    }
                    
                    let reservation = Reservation(id: dataDescription["id"] as? String ?? "",
                                                  type: type,
                                                  isIndividual: dataDescription["isIndividual"] as? Bool ?? true,
                                                  numberOfFreeSlots: dataDescription["numberOfFreeSlots"] as? Int ?? 0,
                                                  trainerName: dataDescription["trainerName"] as? String ?? nil,
                                                  trainerId: dataDescription["trainerId"] as? String ?? nil,
                                                  startDate: Date(timeIntervalSince1970: TimeInterval((dataDescription["startDate"] as? Timestamp)?.seconds ?? 0)),
                                                  endDate: Date(timeIntervalSince1970: TimeInterval((dataDescription["endDate"] as? Timestamp)?.seconds ?? 0)))
                    reservations.append(reservation)
                }
                complition(.success(reservations))
            }
    }
}
