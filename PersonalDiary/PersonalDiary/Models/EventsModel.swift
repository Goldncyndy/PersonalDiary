//
//  EventsModel.swift
//  PersonalDiary
//
//  Created by Cynthia D'Phoenix on 7/26/24.
//

import Foundation
import CoreData

@objc(EventEntity)
public class EventEntity: NSManagedObject {
    @NSManaged public var id: UUID?
    @NSManaged public var imageName: String?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var eventDescription: String?
}

extension EventEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventEntity> {
        return NSFetchRequest<EventEntity>(entityName: "EventEntity")
    }
    
    func update(from model: EventsModel) {
        self.id = model.id
        self.imageName = model.imageName
        self.title = model.title
        self.date = model.date
        self.eventDescription = model.eventDescription
    }
}

struct EventsModel {
    let id: UUID
    let imageName: String
    let title: String
    let date: Date
    let eventDescription: String
}
