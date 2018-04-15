//
//  Person+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Hesham Abd-Elmegid on 10/12/17.
//  Copyright © 2017 CareerFoundry. All rights reserved.
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

}
