//
//  WeightChart+help.swift
//  ABSport
//
//  Created by mac on 13.05.2024.
//

import Foundation
import CoreData
extension WeightChart {
    
    var uuid: UUID {
        uuid_ ?? UUID()
    }
    
    var weight: Float {
        get {weight_}
        set {weight_ = newValue}
    }
    
    var date: Date {
        get {date_ ?? Date()}
        set {date_ = newValue}
    }
    
    convenience init(weight: Float,
                     date: Date,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        self.weight = weight
        self.date = date
    }
    
    public override func awakeFromInsert() {
        self.uuid_ = UUID()
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<WeightChart> {
        let request = WeightChart.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \WeightChart.date_, ascending: true),
                                   NSSortDescriptor(keyPath: \WeightChart.weight_, ascending: true)]
        request.predicate = predicate
        print(request)
        return request
    }
    
    static func fetchLast() -> NSFetchRequest<WeightChart> {
        let request = WeightChart.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \WeightChart.date_, ascending: false)]
        request.fetchLimit = 1
            
        return request
    }
    
    static func editLast(with newWeight: Float, context: NSManagedObjectContext) {
        // let context = CoreDataStack.shared.managedContext
        let fetchRequest: NSFetchRequest<WeightChart> = WeightChart.fetchLast()
        
        do {
            let lastWeightCharts = try context.fetch(fetchRequest)
            if let lastWeightChart = lastWeightCharts.first {
                lastWeightChart.weight_ = newWeight
                try context.save()
            }
        } catch {
            print("Error editing last weight chart: \(error)")
        }
    }
    
    static var example: WeightChart {
        let context = PersistenceController.preview.container.viewContext
        let mark = WeightChart(weight: 78.00, date: Date(), context: context)
        
        return mark
    }
}

