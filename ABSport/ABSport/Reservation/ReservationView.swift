//
//  ReservationView.swift
//  ABSport
//
//  Created by Александр Бобрун on 01.04.2024.
//

import Foundation
import SwiftUI

struct ReservationView<ViewModel: ReservationViewModel>: View {
    
    // MARK: - properties
    
    //@Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        
        ZStack {
            
            mainScreenView()
                .onAppear {
                    withAnimation {
                        viewModel.handle(.openCurrentWeek)
                    }
                }
                .onChange(of: viewModel.state.currentDate) { _ in
                    withAnimation {
                        viewModel.handle(.tapOnDay(withDate: viewModel.state.currentDate))
                    }
                }
        }
    }
    
    // MARK: main screen view
    @ViewBuilder
    func mainScreenView() -> some View {
        
        VStack {
            
            currentDateView()
            
            daysOfMonthWithButtonsView()
//                .gesture(DragGesture(minimumDistance: 25, coordinateSpace: .scrollView(axis: .vertical))
//                    .onEnded({ value in
//                        if value.translation.width < 0 {
//                            withAnimation {
//                                viewModel.openNextWeek()
//                            }
//                        }
//                        
//                        if value.translation.width > 0 {
//                            withAnimation {
//                                viewModel.openPreviousWeek()
//                            }
//                        }
//                    }))
            
            timeTableView()
            
            Spacer()
            
            chooseButton()
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: text with current choosen date
    @ViewBuilder
    func currentDateView() -> some View {
        
        Text(viewModel.formate(date: viewModel.state.currentDate, toType: .dayMonth))
            .foregroundStyle(Color("TextColor"))
            .font(.system(size: 16, weight: .semibold))
            .padding(.top, 32)
            .padding(.bottom, 18)
    }
    
    // MARK: view for choosing current date
    @ViewBuilder
    func daysOfMonthWithButtonsView() -> some View {
        
        HStack {
            Button {
                withAnimation {
                    viewModel.handle(.openPreviousWeek)
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(Color("TextColor"))
            }
            .padding(.leading, 10)
            
            daysOfMonthView()
            
            Button {
                withAnimation {
                    viewModel.handle(.openNextWeek)
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(Color("TextColor"))
            }
            .padding(.trailing, 10)
        }
        .padding(.vertical, 10)
        .background(Color("LightGrayColor"))
        .cornerRadius(12)
    }
    
    // MARK: view for choosing current date
    @ViewBuilder
    func daysOfMonthView() -> some View {
        
        VStack {
            let days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
            
            HStack {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity)
                        .foregroundColor( day == viewModel.formate(date: viewModel.state.currentDate, toType: .week)
                                          ? Color("BlueButtonColor")
                                          : Color("TextColor"))
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible()),
                                count: 7)
            
            LazyVGrid(columns: columns, spacing: 7) {
                ForEach(viewModel.state.currentWeek, id: \.self) { day in
                    Text(viewModel.formate(date: day, toType: .day))
                        .foregroundColor(viewModel.sameDay(date1: viewModel.state.currentDate, date2: day)
                                         ? .white
                                         : Color("TextColor"))
                        .background(
                            Circle()
                                .fill(viewModel.sameDay(date1: viewModel.state.currentDate, date2: day)
                                      ? Color("BlueButtonColor")
                                      : .clear)
                                .frame(width: 22, height: 22, alignment: .center)
                        )
                        .onTapGesture {
                            viewModel.handle(.tapOnDay(withDate: day))
                        }
                }
            }
        }
    }
    
    // MARK: table with all times for current date
    @ViewBuilder
    func timeTableView() -> some View {
        
        VStack {
            if viewModel.state.timeSlotsLoaded {
                Text("Выберите время")
                    .foregroundStyle(Color("TextColor"))
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.top, 38)
                    .padding(.bottom, 21)
                
                let columns = Array(repeating: GridItem(.flexible()),
                                    count: 4)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.state.availableTimeSlots, id: \.self) { timeSlot in
                        timeView(timeSlot: timeSlot)
                    }
                }
                
            } else {
                Spacer()
                
                ProgressView()
                
                Spacer()
            }
        }
        .padding(.horizontal, 26)
        .padding(.top, 10)
    }
    
    // MARK: "Выбрать" button
    @ViewBuilder
    func chooseButton() -> some View {
        
        Button(action: {
            withAnimation {
                viewModel.handle(.tapOnChooseButton(withDate: viewModel.state.choosenTime))
            }
        }, label: {
            Text("Выбрать")
                .foregroundStyle(.white)
                .frame(height: 46)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(viewModel.state.chooseButtonDisabled
                                         ? Color("DarkGrayColor")
                                         : Color("BlueButtonColor"))
                )
        })
        .disabled(viewModel.state.chooseButtonDisabled)
        .padding(.bottom, 27)
    }
    
    // MARK: sample for time slot
    @ViewBuilder
    func timeView(timeSlot: Reservation) -> some View {
    
        let time = viewModel.formate(date: timeSlot.startDate, toType: .time)
        
        Button(action: {
            viewModel.handle(.tapOnTimeSlot(withReservation: timeSlot))
        }, label: {
            Text(time)
                .fontWeight(.light)
                .frame(width: 67, height: 26)
                .foregroundColor(time == viewModel.state.choosenTime
                                 ? Color("BlueButtonColor")
                                 : timeSlot.numberOfFreeSlots <= 0
                                    ? Color("DarkGrayColor")
                                    : Color("TextColor") )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(time == viewModel.state.choosenTime
                                ? Color("BlueButtonColor")
                                : Color("LightGrayColor"), lineWidth: 1)
                )
        })
        .disabled(timeSlot.numberOfFreeSlots <= 0)
    }
}
