//
//  Task+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Hesham Abd-Elmegid on 10/12/17.
//  Copyright © 2017 CareerFoundry. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?

}
