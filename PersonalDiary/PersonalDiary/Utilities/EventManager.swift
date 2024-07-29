//
//  EventManager.swift
//  PersonalDiary
//
//  Created by Cynthia D'Phoenix on 7/26/24.
//
import CoreData
import UIKit

class EventManager {
    static let shared = EventManager()
    private init() {}
    
    var events = [EventsModel]()
    
    func addEvent(_ event: EventsModel) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let eventEntity = EventEntity(context: context)
        eventEntity.id = event.id
        eventEntity.imageName = event.imageName
        eventEntity.title = event.title
        eventEntity.date = event.date
        eventEntity.eventDescription = event.eventDescription
        
        saveContext()
        fetchEvents()
    }
    
    func getEvents() -> [EventsModel] {
        fetchEvents()
        return events
    }
    
    func removeEvent(_ event: EventsModel) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<EventEntity> = EventEntity.fetchRequest() as! NSFetchRequest<EventEntity>
        fetchRequest.predicate = NSPredicate(format: "id == %@", event.id?.uuidString ?? "")
        
        do {
            let eventEntities = try context.fetch(fetchRequest)
            if let eventEntity = eventEntities.first {
                context.delete(eventEntity)
                saveContext()
                fetchEvents()
            }
        } catch {
            print("Failed to delete event: \(error)")
        }
    }
    
    func fetchEvents() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<EventEntity> = EventEntity.fetchRequest() as! NSFetchRequest<EventEntity>
        
        do {
            let eventEntities = try context.fetch(fetchRequest)
            events = eventEntities.map { eventEntity in
                EventsModel(id: eventEntity.id ?? UUID(), imageName: eventEntity.imageName ?? "", title: eventEntity.title ?? "", date: eventEntity.date ?? Date(), eventDescription: eventEntity.eventDescription ?? "")
            }
        } catch {
            print("Failed to fetch events: \(error)")
        }
    }
    
    private func saveContext() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
