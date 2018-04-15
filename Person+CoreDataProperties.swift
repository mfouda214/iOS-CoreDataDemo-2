//
//  Person+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Mohamed Sobhi  Fouda on 4/15/18.
//  Copyright © 2018 CareerFoundry. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: Int32
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension Person {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
