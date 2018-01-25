//
//  Message+CoreDataProperties.swift
//  FBMessengerClone
//
//  Created by MacBookPro on 1/23/18.
//  Copyright © 2018 basicdas. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var friend: Friend?

}
