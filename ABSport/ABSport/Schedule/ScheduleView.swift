//
//  ScheduleView.swift
//  SwiftUIPlayground
//
//  Created by Александр Бобрун on 11.03.2024.
//

import SwiftUI

struct ScheduleView<ViewModel: ScheduleViewModel>: View {
    
    // MARK: - properties
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - body and ViewBuilder functions
    
    // MARK: body
    var body: some View {
        ZStack {
            Color("BackgroundColor")
            mainScreenView()
                .onAppear {
                    viewModel.handle(.openCurrentMonth)
                }
                .onChange(of: viewModel.state.currentMonthDates) { _ in
                    viewModel.handle(.openCurrentMonth)
                }
        }
        
    }
    
    // MARK: ViewBuilder function to draw month and year picker
    @ViewBuilder
    func monthPicker() -> some View {
        DatePicker("", selection: $viewModel.state.currentMonth, displayedComponents: [.date])
            .labelsHidden()
            .datePickerStyle(.wheel)
    }
    
    // MARK: ViewBuilder function to draw main screen view
    @ViewBuilder
    func mainScreenView() -> some View {
        
        ScrollView {
            VStack(alignment: .center) {
                currentDateView()
                
                if viewModel.state.calendarShowing {
                    daysOfMonthWithButtonsView()
                    //                    .gesture(DragGesture(minimumDistance: 25, coordinateSpace: .scrollView(axis: .vertical))
                    //                        .onEnded({ value in
                    //                            value.translation.width < 0 ? viewModel.openNextMonth() : viewModel.openPreviousMonth()
                    //                        }))
                }
                Spacer()
                if viewModel.state.reservationsFetched {
                    tasksAndReservationList(forDate: viewModel.state.currentDate)
                } else {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                
            }
            .padding(.horizontal, 16)
        }
    }
    
    // MARK: text with current choosen date
    @ViewBuilder
    func currentDateView() -> some View {
        
        HStack(alignment: .center) {
            Text(viewModel.formate(date: viewModel.state.currentDate,
                                   toType: .dayMonthYear))
            .foregroundStyle(Color("BlueButtonColor"))
            .font(.system(size: 16, weight: .semibold))
            
            Button {
                withAnimation {
                    viewModel.handle(.tapOnShowCalendarButton)
                }
            } label: {
                Image(systemName: viewModel.state.calendarShowing ? "chevron.up.circle" : "chevron.down.circle")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color("BlueButtonColor"))
            }
        }
        .padding(.top, 32)
        .padding(.bottom, 18)
    }
    
    // MARK: ViewBuilder function to draw view for choosing current date
    @ViewBuilder
    func daysOfMonthWithButtonsView() -> some View {
        
        HStack {
            Button {
                withAnimation {
                    viewModel.handle(.openPreviousMonth)
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundStyle(Color("TextColor"))
            }
            .padding(.leading, 10)
            
            daysOfMonthView()
            
            Button {
                withAnimation {
                    viewModel.handle(.openNextMonth)
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundStyle(Color("TextColor"))
            }
            .padding(.trailing, 10)
        }
        .padding(.vertical, 10)
        .background(Color("LightGrayColor"))
        .cornerRadius(12)
    }
    
    // MARK: ViewBuilder function to draw view for choosing current date
    @ViewBuilder
    func daysOfMonthView() -> some View {
            
        VStack {
            // MARK: - hardcode
            let days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
            HStack {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(day == viewModel.formate(date: viewModel.state.currentDate,
                                                                  toType: .week)
                                          ? Color("BlueButtonColor")
                                          : Color("TextColor"))
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible()),
                                count: 7)
            LazyVGrid(columns: columns, spacing: 7) {
                ForEach(viewModel.state.currentMonthDates, id: \.self) { day in
                    dayOfCalendar(day: day)
                        .transition(.scale.combined(with: .offset(x: 100, y: 0)))
                        .onTapGesture {
                            viewModel.handle(.tapOnDay(withDate: day))
                        }
                }
            }
            .animation(.linear, value: viewModel.state.currentMonthDates)
        }
    }
    
    // MARK: ViewBuilder function to draw table elements of each day
    @ViewBuilder
    func dayOfCalendar(day: Date) -> some View {
        
        VStack(spacing: 3) {
            Text(viewModel.formate(date: day, toType: .day))
                .foregroundColor(viewModel.daysInDifferentMonths(date1: day,
                                                                 date2: viewModel.state.currentDate)
                                 ? Color("DarkGrayColor")
                                 : viewModel.sameDay(date1: viewModel.state.currentDate,
                                                     date2: day)
                                    ? .white
                                    : Color("TextColor"))
                .font(.system(size: 16))
                .background(
                    Circle()
                        .fill(viewModel.sameDay(date1: viewModel.state.currentDate,
                                                date2: day)
                              ? Color("BlueButtonColor")
                              : .clear)
                        .frame(width: 22, height: 22, alignment: .center)
                )
            circlesUnderDay(currentDateOfDay: day)
        }
        .frame(height: 30, alignment: .top)
    }
    
    // MARK: ViewBuilder function to draw circles of reservations
    @ViewBuilder
    func circlesUnderDay(currentDateOfDay date: Date) -> some View {
        
        HStack(spacing: 3) {
            if let reservations = viewModel.state.allReservations[viewModel.formate(date: date,
                                                                                    toType: .dayMonthYear)] {
                
                if reservations.contains(where: { $0.type == .runningTraining }) {
                    Circle()
                        .fill(Color("RunningTrainingColor"))
                        .frame(width: 3, height: 3)
                }
                
                if reservations.contains(where: { $0.type == .poolTraining }) {
                    Circle()
                        .fill(Color("PoolTrainingColor"))
                        .frame(width: 3, height: 3)
                }
                
                if reservations.contains(where: { $0.type == .bicycleTraining }) {
                    Circle()
                        .fill(Color("BikeTrainingColor"))
                        .frame(width: 3, height: 3)
                }
            }
        }
    }
    
    // MARK: ViewBuilder function to draw all reservations for the current date
    @ViewBuilder
    func tasksAndReservationList(forDate date: Date) -> some View {
        
        if let reservations = viewModel.state.allReservations[viewModel.formate(date: date,
                                                                                toType: .dayMonthYear)], 
            !reservations.isEmpty {
            VStack {
                ForEach(reservations.sorted(by: { $0.startDate <= $1.startDate })) { reservation in
                    reservationCell(reservation: reservation)
                }
            }
        } else {
            Text("Нет записей")
        }
    }
    
    // MARK: ViewBuilder function to draw one current reservation for the current date
    @ViewBuilder
    func reservationCell(reservation: Reservation) -> some View {
        
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.formate(date: reservation.startDate, toType: .weekDayMonthYear).capitalized)
                    .font(.system(size: 14))
                    .foregroundColor(Color("RedButtonColor"))
                
                HStack(spacing: 0) {
                    Text(reservation.type.rawValue)
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                    let startDate = viewModel.formate(date: reservation.startDate, toType: .time)
                    let endDate = viewModel.formate(date: reservation.endDate, toType: .time)
                    Text("\(startDate) - \(endDate)")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color("GreenTextColor"))
                }
                .padding(.vertical, 14)
                
                Text("\(reservation.isIndividual ? "Индивидуальная тренировка" : "Групповая тренировка")")
                    .font(.system(size: 14))
                    .frame(height: 24)
                Text("Тренер: \(reservation.trainerName ?? "не указан")")
                    .font(.system(size: 14))
                    .frame(height: 24)
//                Text("Осталось мест: \(reservation.numberOfFreeSlots)")
//                    .font(.system(size: 14))
//                    .frame(height: 24)
//                    .padding(.bottom, 14)
            }
            .padding(.horizontal, 5)
            Button {
                viewModel.handle(.tapOnCancelButton(reservation: reservation))
            } label: {
                Text("Отменить запись")
                    .foregroundColor(Color("RedButtonColor"))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("RedButtonColor"), lineWidth: 1)
                    )
            }
        }
        .padding(9)
        .frame(maxWidth: .infinity)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("LightGrayColor"), lineWidth: 2)
        )
    }
}
