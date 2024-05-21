//
//  DataManager.swift
//  ABSport
//
//  Created by mac on 17.05.2024.
//

import Foundation
import CoreData
import SwiftUI

struct WeightData {
    let date: Date
    let weight: Float
}

final class ChartDataManager {
    
    func fetchWeightData(_ predicate: NSPredicate = .all, context: NSManagedObjectContext) -> [WeightData] {
        let fetchRequest = WeightChart.fetch(predicate)
        
        do {
            let weightCharts = try context.fetch(fetchRequest)
            let weightDataArray = weightCharts.map { WeightData(date: $0.date, weight: $0.weight) }
            return weightDataArray
        } catch {
            print("Failed to fetch weight data: \(error)")
            
            return []
        }
    }
    
    func dataWrapper(data: FetchedResults<WeightChart>) {
        let weightDataArray = data.map { WeightData(date: $0.date, weight: $0.weight) }
    }
    
    func filterDataForWeek(data: FetchedResults<WeightChart>) -> [WeightChart] {
        let calendar = Calendar.current
        let today = getCurrentDateTimeInLocalTimezone()
        guard let oneWeekAgo = calendar.date(byAdding: .weekOfYear, value: -1, to: today) else { return [] }

        // Отладочная информация
        print("Today: \(today)")
        print("One week ago: \(oneWeekAgo)")
        
        // Фильтрация данных
        let filterData = data.filter { $0.date >= oneWeekAgo }
        
        // Печать количества отфильтрованных данных и их деталей
        print("Filtered data count: \(filterData.count)")
        for entry in filterData {
            print("Date: \(entry.date), Weight: \(entry.weight)")
        }
        
        return filterData
    }
    
    func filterDataForMonth(data: FetchedResults<WeightChart>) -> [WeightChart] {
        let calendar = Calendar.current
        let today = Date()
        guard let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: today) else { return [] }
        
        print("Today: \(today)")
        print("One month ago: \(oneMonthAgo)")
        
        let filterData = data.filter { $0.date >= oneMonthAgo }
        
        print("Filtered data count: \(filterData.count)")
        for entry in filterData {
            print("Date: \(entry.date), Weight: \(entry.weight)")
        }
        
        return filterData
    }
    
    func filterDataForHalfYear(data: FetchedResults<WeightChart>) -> [WeightChart] {
        let calendar = Calendar.current
        let today = Date()
        guard let sixMonthsAgo = calendar.date(byAdding: .month, value: -6, to: today) else { return [] }
        
        return data.filter { $0.date >= sixMonthsAgo }
    }
    
    func filterDataForYear(data: FetchedResults<WeightChart>) -> [WeightChart] {
        let calendar = Calendar.current
        let today = Date()
        guard let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: today) else { return []
        }
        return data.filter{ $0.date >= oneYearAgo }
    }
}

let data: [WeightData] = [
    WeightData(date: Date(), weight: 70.5),
    WeightData(date: Date(timeIntervalSinceNow: -86400 * 7), weight: 71.0), // вес за неделю
    WeightData(date: Date(timeIntervalSinceNow: -86400 * 30), weight: 72.0), // вес за месяц
    WeightData(date: Date(timeIntervalSinceNow: -86400 * 180), weight: 73.0) // вес за полгода
]

// let dataForWeek = filterDataForWeek(data: data)
// let dataForMonth = filterDataForMonth(data: data)
// let dataForHalfYear = filterDataForHalfYear(data: data)
