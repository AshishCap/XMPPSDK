//
//  MediaManager.swift
//  TestProject
//
//  Created by ashish on 7/8/19.
//  Copyright © 2019 Capanicus. All rights reserved.
//

import UIKit
import CoreData

@objc public class MediaManager: NSObject
{
    /*--------- initiate shared manager   ------------*/
    @objc class var sharedInstance: MediaManager
    {
        struct Static
        {
            static let instance : MediaManager = MediaManager()
        }
        return Static.instance
    }
    
    
    @objc func saveMedia(messageId:String, mediaUrl:String, thumbnailData:String, mediaType:String)
    {
        let managedContext = XMPPUserManager.shared()?.xmppMessageArchivingCoreDataStorage.managedObjectContext//(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let media:MediaData  = NSEntityDescription.insertNewObject(forEntityName: "MediaData", into: managedContext!) as! MediaData
        
        media.messageId         = messageId
        media.mediaUrl          = mediaUrl
        media.base64String      = thumbnailData
        media.mediaType         = mediaType
        
        DispatchQueue.main.async {
            do
            {
                try managedContext!.save()
                print("MediaData saved")
            } catch let error as NSError {
                print("MediaData Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    @objc func updateMedia(messageId:String, mediaUrl:String, thumbnailData:String, mediaType:String)
    {
        let context         = XMPPUserManager.shared()?.xmppMessageArchivingCoreDataStorage.managedObjectContext//(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest    = NSFetchRequest<NSFetchRequestResult>(entityName: "MediaData")
        fetchRequest.predicate = NSPredicate(format: "mediaType == %@", mediaType)
        
        do {
            let results : NSArray = try context!.fetch(fetchRequest) as NSArray
            if (results.count > 0)
            {
                let mediaData : MediaData = (results.object(at: 0) as? MediaData)!
                mediaData.mediaUrl = mediaUrl
                
                do
                {
                    try context!.save()
                    print("MediaUrl Updated")
                    
                } catch let error as NSError {
                    print("MediaUrl Could not update. \(error), \(error.userInfo)")
                }
            }
            else
            {
                let media:MediaData  = NSEntityDescription.insertNewObject(forEntityName: "MediaData", into: context!) as! MediaData
                
                media.messageId         = messageId
                media.mediaUrl          = mediaUrl
                media.base64String      = thumbnailData
                media.mediaType         = mediaType
                
                DispatchQueue.main.async {
                    do
                    {
                        try context!.save()
                        print("MediaData saved")
                    } catch let error as NSError {
                        print("MediaData Could not save. \(error), \(error.userInfo)")
                    }
                }
            }
        }catch let err as NSError {
            print(err.debugDescription)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "GROUPAVTARCHANGENOTIFICATION"), object: nil, userInfo: nil)
    }
    
    @objc func GetGroupAvtar(mediaType:String) -> String
    {
        let context         = XMPPUserManager.shared()?.xmppMessageArchivingCoreDataStorage.managedObjectContext//(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest    = NSFetchRequest<NSFetchRequestResult>(entityName: "MediaData")
        fetchRequest.predicate = NSPredicate(format: "mediaType == %@", mediaType)
        
        let results : NSArray = try! context!.fetch(fetchRequest) as NSArray
        if (results.count > 0)
        {
            let mediaData : MediaData = (results.object(at: 0) as? MediaData)!
            return mediaData.mediaUrl ?? ""
        }
        else
        {
            return ""
        }
    }
    
    func updateMediaUrl(messageId:String, mediaUrl:String)
    {
        let context         = XMPPUserManager.shared()?.xmppMessageArchivingCoreDataStorage.managedObjectContext//(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest    = NSFetchRequest<NSFetchRequestResult>(entityName: "MediaData")
        fetchRequest.predicate = NSPredicate(format: "messageId == %@", messageId)
        
        do {
            let results : NSArray = try context!.fetch(fetchRequest) as NSArray
            if (results.count > 0)
            {
                let mediaData : MediaData = (results.object(at: 0) as? MediaData)!
                mediaData.mediaUrl = mediaUrl
                
                do
                {
                    try context!.save()
                    print("MediaUrl Updated")
                    
                } catch let error as NSError {
                    print("MediaUrl Could not update. \(error), \(error.userInfo)")
                }
            }
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func getMediaWithMessageId(messageId: String) -> NSArray
    {
        let managedContext = XMPPUserManager.shared()?.xmppMessageArchivingCoreDataStorage.managedObjectContext//(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MediaData")
        let predicate = NSPredicate(format: "messageId == %@", messageId)
        fetchRequest.predicate = predicate
        
        let results : NSArray = try! managedContext!.fetch(fetchRequest) as NSArray
        
        return results
    }
    
    func deleteMediaData(messageId: String?) {
        
        let managedContext  = XMPPUserManager.shared().xmppMessageNSManagedObjectContext()//AppUtility.sharedInstance.mainManagedObjectContext()
        
        let fetchRequest    = NSFetchRequest<NSFetchRequestResult>(entityName: "MediaData")
        fetchRequest.predicate = NSPredicate(format: "messageId = %@", messageId!)
        
        let result = try? managedContext!.fetch(fetchRequest)
        let mediaData = result as! [MediaData]
        
        for media in mediaData {
            managedContext!.delete(media)
        }
        
        DispatchQueue.main.async {
            do {
                try managedContext!.save()
                print("MediaData deleted!")
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    func getAllMedia()
    {
        let managedContext = XMPPUserManager.shared()?.xmppMessageArchivingCoreDataStorage.managedObjectContext//(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MediaData")
        
        let results : NSArray = try! managedContext!.fetch(fetchRequest) as NSArray
        
        print(results)
    }
}
