//
//  GroupTrainingViewModel.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 22.04.2024.
//

import UIKit

protocol GroupTrainingViewModelDelegate: AnyObject {
    func didTapChooseTrainerButton()
    func didTapChooseTrainingButton()
    func didTapChooseDateButton()
}

class GroupTrainingViewModel: GroupTrainingViewModelDelegate {
    
    weak var coordinator: GroupTrainingCoordinator?
    
    //    var training: Training = Training(trainerName: "", trainingType: .bike, trainingDate: Date())
    
    private let calendarManager: CalendarManager
        private let dateFormatterManager: DateFormatterManager
        
    init(dateFormatterManager: DateFormatterManager, calendarManager: CalendarManager) {
            self.dateFormatterManager = dateFormatterManager
            self.calendarManager = calendarManager
        }
    
    var notificationCenter = NotificationCenter.default
    var trainerName: String?
    
    func didTapChooseTrainerButton() {
        coordinator?.goToChooseTrainer()
    }
    
    func didTapChooseTrainingButton() {
        coordinator?.goToChooseTraining()
    }
    
    func didTapChooseDateButton() {
        coordinator?.goToReservation()
    }
    
    func didTapChooseButton() {
        print("reg training")
        if TrainingRegistation.shared.trainingRegistation.trainingType != .unknown {
            TrainingRegistation.shared.addTraining()
            addNotification(time: 0.1,
                            title: "Уведомление о записи",
                            subtitle: "",
                            body: "Вы записаны \(dateFormatterManager.formate(
date: TrainingRegistation.shared., toType: .dayMonth)) на время: \(dateFormatterManager.formate(date: date, toType: .time))")
            var newReservation = ReservationManager.shared.allTimeSlots[dateFormatterManager.formate(date: state.currentDate, toType: .dayMonthYear)]?.first(where: {
                dateFormatterManager.formate(date: $0.startDate, toType: .time) == dateFormatterManager.formate(date: date, toType: .time)})
            newReservation?.trainerName = "Some name"
            ReservationManager.shared.activeReservations[dateFormatterManager.formate(date: state.currentDate, toType: .dayMonthYear), default: []].append(newReservation!)
            print(ReservationManager.shared.activeReservations)
            ReservationManager.shared.allTimeSlots[dateFormatterManager.formate(date: state.currentDate, toType: .dayMonthYear)]?.removeAll(where: {
                dateFormatterManager.formate(date: $0.startDate, toType: .time) == dateFormatterManager.formate(date: date, toType: .time)})
        }
        TrainingRegistation.shared.clearRegistation()
        coordinator?.gotoMain()
        
        
    }
    
    func addNotification(time: Double, title: String, subtitle: String, body: String) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
            print("add notification")
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
                    if success {
                        addRequest()
                    } else {
                        print("Authorization declined")
                    }
                }
            }
        }
    }
}
