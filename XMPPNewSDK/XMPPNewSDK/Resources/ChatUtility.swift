//
//  ChatUtility.swift
//  TestProject
//
//  Created by ashish on 7/8/19.
//  Copyright © 2019 Capanicus. All rights reserved.
//

import Foundation
import CoreData
import XMPPFramework

public final class ChatUtility
{
    private init() {}
    public static let shared = ChatUtility()
    
    func getXmppContactEntity(bareJidStr: String,completionHandler: (_ chatmessages: XMPPMessageArchiving_Contact_CoreDataObject?) -> ())
    {
        let Context = XMPPUserManager.shared().xmppMessageNSManagedObjectContext()
        let entity : NSEntityDescription = XMPPUserManager.shared().xmppMessageArchivingCoreDataStorage.contactEntity(Context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        
        fetchRequest.predicate = NSPredicate(format: "bareJidStr == %@", bareJidStr)
        
        let results : NSArray = try! Context!.fetch(fetchRequest) as NSArray
        
        if results.count > 0
        {
            completionHandler((results.object(at: 0) as? XMPPMessageArchiving_Contact_CoreDataObject)!)
        } else {
            completionHandler(nil)
        }
    }
    
    func getXmppMessageEntity(messageId: String,completionHandler: (_ chatmessages: XMPPMessageArchiving_Message_CoreDataObject?) -> ())
    {
        let Context = XMPPUserManager.shared().xmppMessageNSManagedObjectContext()
        let entity : NSEntityDescription = XMPPUserManager.shared().xmppMessageArchivingCoreDataStorage.messageEntity(Context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        
        fetchRequest.predicate = NSPredicate(format: "messageId == %@", messageId)
        
        let results : NSArray = try! Context!.fetch(fetchRequest) as NSArray
        
        if results.count > 0
        {
            completionHandler((results.object(at: 0) as? XMPPMessageArchiving_Message_CoreDataObject)!)
        } else {
            completionHandler(nil)
        }
    }
    
    func getXmppContactUnreadMessageCount(completionHandler: (_ unreadCount: Int?) -> ())
    {
        let Context = XMPPUserManager.shared().xmppMessageNSManagedObjectContext()
        let entity : NSEntityDescription = XMPPUserManager.shared().xmppMessageArchivingCoreDataStorage.contactEntity(Context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        
        let results : NSArray = try! Context!.fetch(fetchRequest) as NSArray
        
        var unreadCount = 0
        for Contact_CoreDataObject in results {
            let chatmessages = Contact_CoreDataObject as? XMPPMessageArchiving_Contact_CoreDataObject
            unreadCount = unreadCount + Int((chatmessages?.unreadMessageCount != nil ? chatmessages?.unreadMessageCount : "0")!)!
        }
        
        if unreadCount > 0
        {
            completionHandler(unreadCount)
        } else {
            completionHandler(nil)
        }
    }
}
