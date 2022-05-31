//
//  Todo+CoreDataProperties.swift
//  Todo App
//
//  Created by Tommy Yon Prakoso on 10/05/22.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var content: String?
    @NSManaged public var title: String?
    @NSManaged public var isDone: Bool

}
