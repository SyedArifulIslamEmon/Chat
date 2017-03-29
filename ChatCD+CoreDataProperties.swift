//
//  ChatCD+CoreDataProperties.swift
//  
//
//  Created by Sierra 4 on 27/03/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ChatCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatCD> {
        return NSFetchRequest<ChatCD>(entityName: "ChatCD");
    }

    @NSManaged public var chatType: Int32
    @NSManaged public var date: String?
    @NSManaged public var id: Int32
    @NSManaged public var message: String?
    @NSManaged public var name: String?
    @NSManaged public var other_id: Int32
    @NSManaged public var sender_id: Int32
    @NSManaged public var status: Int32
    @NSManaged public var timezone: String?

}
