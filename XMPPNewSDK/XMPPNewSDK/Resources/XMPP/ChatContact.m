//
//  ChatContact.m
//  GoIDD
//
//  Created by apple on 20/06/17.
//  Copyright © 2017 GoIDD. All rights reserved.
//

#import "ChatContact.h"

@implementation ChatContact

- (id) init:(NSString*)bareJid bareJidStr:(NSString*)bareJidStr mostRecentMessageTimestamp:(NSDate*)mostRecentMessageTimestamp mostRecentMessageBody:(NSString*)mostRecentMessageBody mostRecentMessageOutgoing:(NSNumber*)mostRecentMessageOutgoing streamBareJidStr:(NSString*)streamBareJidStr groupName:(NSString*)groupName unreadCount:(NSString*)unreadCount groupImage:(NSString*)groupImage displayName:(NSString*)displayName
{
    if (self=[super init])
    {
        self.bareJid =[bareJid stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        self.bareJidStr =[bareJidStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        self.mostRecentMessageTimestamp = mostRecentMessageTimestamp ;
        
        self.mostRecentMessageBody =[mostRecentMessageBody stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        self.mostRecentMessageOutgoing = mostRecentMessageOutgoing;
        
        self.streamBareJidStr =[streamBareJidStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
         self.groupName =[groupName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
         self.unreadCount =[unreadCount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
         self.groupImage =[groupImage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.displayName = displayName;
    }
    return self;
}

@end

////#import "MediaManagerObjC.h"
//#import "XMPPUserManager.h"
//#import <CoreData/CoreData.h>
//
//static MediaManagerObjC* manager = nil;
//
//@implementation MediaManagerObjC
//
//+ (MediaManagerObjC*) sharedManager
//{
//    @synchronized(manager)
//    {
//        if (manager==nil)
//        {
//            manager = [[MediaManagerObjC alloc] init];
//        }
//    }
//    return manager;
//}
//
//
//- (void)saveMediaWithMessageId:(NSString *)messageId MediaUrl:(NSString *)mediaUrl ThumbnailData:(NSString *)thumbnailData MediaType:(NSString *)mediaType
//{
//    NSManagedObjectContext *moc = [XMPPUserManager sharedManager].xmppMessageArchivingCoreDataStorage.mainThreadManagedObjectContext;
//
//    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:moc];
//
//    [newDevice setValue:mediaUrl forKey:@"mediaUrl"];
//    [newDevice setValue:thumbnailData forKey:@"base64String"];
//    [newDevice setValue:mediaType forKey:@"mediaType"];
//    [newDevice setValue:messageId forKey:@"messageId"];
//
//    NSError *error = nil;
//    // Save the object to persistent store
//    if (![moc save:&error])
//    {
//        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//    }
//}
//
//- (void)updateMediaUrlWithMessageId:(NSString *)messageId MediaUrl:(NSString *)mediaUrl
//{
//    NSManagedObjectContext *moc = [XMPPUserManager sharedManager].xmppMessageArchivingCoreDataStorage.mainThreadManagedObjectContext; //self.xmppMessageArchivingCoreDataStorage.mainThreadManagedObjectContext;
//
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MediaData" inManagedObjectContext:moc];//[[XMPPUserManager sharedManager].xmppMessageArchivingCoreDataStorage messageEntity:moc];
//
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"messageId == %@",messageId];
//
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    [fetchRequest setEntity:entity];    //[fetchRequest setFetchLimit:1];
//    [fetchRequest setPredicate:predicate];
//
//    NSError *error = nil;
//    NSArray * arr  = [moc executeFetchRequest:fetchRequest error:&error];
//    if (arr.count > 0)
//    {
//        NSManagedObject *contact = [arr objectAtIndex:0];
//        [contact setValue:mediaUrl forKey:@"mediaUrl"];
//
//        NSError *error;
//        if ([moc save:&error])
//        {
//            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//        }
//    }
//}
//
//- (void)updateMediaWithMessageId:(NSString *)messageId MediaUrl:(NSString *)mediaUrl ThumbnailData:(NSString *)thumbnailData MediaType:(NSString *)mediaType
//{
//    NSManagedObjectContext *moc = [XMPPUserManager sharedManager].xmppMessageArchivingCoreDataStorage.mainThreadManagedObjectContext; //self.xmppMessageArchivingCoreDataStorage.mainThreadManagedObjectContext;
//
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MediaData" inManagedObjectContext:moc];//[[XMPPUserManager sharedManager].xmppMessageArchivingCoreDataStorage messageEntity:moc];
//
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"messageId == %@",messageId];
//
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    [fetchRequest setEntity:entity];    //[fetchRequest setFetchLimit:1];
//    [fetchRequest setPredicate:predicate];
//
//    NSError *error = nil;
//    NSArray * arr  = [moc executeFetchRequest:fetchRequest error:&error];
//    if (arr.count > 0)
//    {
//        NSManagedObject *contact = [arr objectAtIndex:0];
//        [contact setValue:mediaUrl forKey:@"mediaUrl"];
//        [contact setValue:thumbnailData forKey:@"base64String"];
//        [contact setValue:mediaType forKey:@"mediaType"];
//
//        NSError *error;
//        if ([moc save:&error])
//        {
//            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//        }
//    }
//}
//
//- (NSString *)GetGroupAvtarWithMediaType:(NSString *)mediaType
//{
//    NSManagedObjectContext *moc = [XMPPUserManager sharedManager].xmppMessageArchivingCoreDataStorage.mainThreadManagedObjectContext; //self.xmppMessageArchivingCoreDataStorage.mainThreadManagedObjectContext;
//
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MediaData" inManagedObjectContext:moc];//[[XMPPUserManager sharedManager].xmppMessageArchivingCoreDataStorage messageEntity:moc];
//
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mediaType == %@",mediaType];
//
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    [fetchRequest setEntity:entity];    //[fetchRequest setFetchLimit:1];
//    [fetchRequest setPredicate:predicate];
//
//    NSError *error = nil;
//    NSArray * arr  = [moc executeFetchRequest:fetchRequest error:&error];
//    if (arr.count > 0)
//    {
//        NSManagedObject *contact = [arr objectAtIndex:0];
//        return [contact valueForKey:@"mediaUrl"];
//    }
//    else
//    {
//        return @"";
//    }
//}
//
//- (NSArray *)getMediaWithMessageId:(NSString *)messageId
//{
//    NSManagedObjectContext *moc = [XMPPUserManager sharedManager].xmppMessageArchivingCoreDataStorage.mainThreadManagedObjectContext; //self.xmppMessageArchivingCoreDataStorage.mainThreadManagedObjectContext;
//
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MediaData" inManagedObjectContext:moc];//[[XMPPUserManager sharedManager].xmppMessageArchivingCoreDataStorage messageEntity:moc];
//
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"messageId == %@",messageId];
//
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    [fetchRequest setEntity:entity];    //[fetchRequest setFetchLimit:1];
//    [fetchRequest setPredicate:predicate];
//
//    NSError *error = nil;
//    NSArray * arr  = [moc executeFetchRequest:fetchRequest error:&error];
//    return arr;
//}
//
//- (void)deleteMediaDataWithMessageId:(NSString *)messageId
//{
//    NSManagedObjectContext *moc = [XMPPUserManager sharedManager].xmppMessageArchivingCoreDataStorage.mainThreadManagedObjectContext; //self.xmppMessageArchivingCoreDataStorage.mainThreadManagedObjectContext;
//
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MediaData" inManagedObjectContext:moc];//[[XMPPUserManager sharedManager].xmppMessageArchivingCoreDataStorage messageEntity:moc];
//
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"messageId == %@",messageId];
//
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    [fetchRequest setEntity:entity];    //[fetchRequest setFetchLimit:1];
//    [fetchRequest setPredicate:predicate];
//
//    NSError *error = nil;
//    NSArray * arr  = [moc executeFetchRequest:fetchRequest error:&error];
//    if (arr.count > 0)
//    {
//        //NSManagedObject *contact = [arr objectAtIndex:0];
//        for (NSManagedObject *managedObject in arr)
//        {
//            [moc deleteObject:managedObject];
//        }
//
//        NSError *error;
//        if ([moc save:&error])
//        {
//            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//        }
//    }
//}
//
//@end
//
