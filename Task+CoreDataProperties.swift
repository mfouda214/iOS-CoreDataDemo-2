//
//  Task+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Mohamed Sobhi  Fouda on 4/15/18.
//  Copyright © 2018 CareerFoundry. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var person: Person?

}
