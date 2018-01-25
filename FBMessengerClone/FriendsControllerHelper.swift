//
//  FriendsControllerHelper.swift
//  FBMessengerClone
//
//  Created by MacBookPro on 1/23/18.
//  Copyright © 2018 basicdas. All rights reserved.
//

import UIKit
import CoreData


extension FriendsController {
    
    
    func setupData() {
        
        clearData()
        
        let context = DatabaseController.getContext()
        
        let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        mark.name = "Mark Zuckerberg"
        mark.profileImageName = "zuck_profile"
        
        createMessageWithText(text: "Hello, my name is Mark and nice to meet you", friend: mark, context: context, minutesAgo: 60 * 24)
        
        createSteveMessagesWithContext(context: context)
        
        
        
        let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        donald.name = "Donald Trump"
        donald.profileImageName = "donald_profile"
        
        createMessageWithText(text: "You're fired...!!!", friend: donald, context: context, minutesAgo: 60 * 24 * 8)
        
        
        DatabaseController.saveContext()
        
        //messages = [messageMark, messageSteve]
        
        loadData()
    }
    
    private func createSteveMessagesWithContext(context: NSManagedObjectContext) {
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve_profile"
        
        createMessageWithText(text: "Hi, Good Morning...", friend: steve, context: context, minutesAgo: 4)
        createMessageWithText(text: "Apple creates great iOS devices for the world. Please try us and see by yourselves.", friend: steve, context: context, minutesAgo: 3)
        createMessageWithText(text: "Are you interested in buying Apple devices? I don't know what I am talking about. I just typing to make sentence a little longer to make it three lines of text.", friend: steve, context: context, minutesAgo: 2)
        
        // response message
        createMessageWithText(text: "Yes, totally looking forward to buy iPhoneX", friend: steve, context: context, minutesAgo: 1, isSender: true)
    }
    
    private func createMessageWithText(text: String, friend: Friend, context: NSManagedObjectContext, minutesAgo: Double, isSender: Bool = false) {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(-minutesAgo * 60)
        message.isSender = isSender
    }
    
    func loadData() {
        
        let context = DatabaseController.getContext()
        
        if let friends = fetchFriends() {
            
            messages = [Message]()
            
            for friend in friends {
                let fetchRequest: NSFetchRequest<Message> = Message.fetchRequest()
                fetchRequest.sortDescriptors = [NSSortDescriptor(key:"date", ascending: false)]
                fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                fetchRequest.fetchLimit = 1
                
                do {
                    let fetchedMessages = try context.fetch(fetchRequest)
                    messages?.append(contentsOf: fetchedMessages)
                } catch let err as NSError {
                    print("Error: \(err.localizedDescription)")
                }
            }
            
            messages?.sort(by: { (message1, message2) -> Bool in
                return message1.date!.compare(message2.date! as Date) == .orderedDescending
            })
        }
        
        
        
        
        
        
    }
    
    private func fetchFriends() -> [Friend]? {
        let context = DatabaseController.getContext()
        
        let fetchRequest: NSFetchRequest<Friend> = Friend.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch let err as NSError {
            print("Error: \(err.localizedDescription)")
        }
        
        return nil
    }
    
    func clearData() {
        let context = DatabaseController.getContext()
        
        do {
            let entityNames = ["Message", "Friend"]
            
            for entityName in entityNames {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                
                let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
                
                for object in objects! {
                    context.delete(object)
                }
            }
        } catch let err as NSError {
            print("Error: \(err.localizedDescription)")
        }
    }
    
}









