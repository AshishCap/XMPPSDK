//
//  ChatContact.h
//  GoIDD
//
//  Created by apple on 20/06/17.
//  Copyright © 2017 GoIDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatContact : NSObject
@property (nonatomic, strong) NSString  * bareJid;
@property (nonatomic, strong) NSString  * bareJidStr;

@property (nonatomic, strong) NSDate    * mostRecentMessageTimestamp;
@property (nonatomic, strong) NSString  * mostRecentMessageBody;
@property (nonatomic, strong) NSNumber  * mostRecentMessageOutgoing;

@property (nonatomic, strong) NSString  * streamBareJidStr;
@property (nonatomic, strong) NSString  * groupName;
@property (nonatomic, strong) NSString  * unreadCount;
@property (nonatomic, strong) NSString  * groupImage;

@property (nonatomic, strong) NSString  * displayName;

- (id) init:(NSString*)bareJid bareJidStr:(NSString*)bareJidStr mostRecentMessageTimestamp:(NSDate*)mostRecentMessageTimestamp mostRecentMessageBody:(NSString*)mostRecentMessageBody mostRecentMessageOutgoing:(NSNumber*)mostRecentMessageOutgoing streamBareJidStr:(NSString*)streamBareJidStr groupName:(NSString*)groupName unreadCount:(NSString*)unreadCount groupImage:(NSString*)groupImage displayName:(NSString*)displayName;
@end

//@interface MediaManagerObjC : NSObject
//
//+ (MediaManagerObjC *) sharedManager;
//
//-(void) saveMediaWithMessageId:(NSString*)messageId MediaUrl:(NSString*)mediaUrl ThumbnailData:(NSString*)thumbnailData MediaType:(NSString*)mediaType;
//
//-(void) updateMediaWithMessageId:(NSString*)messageId MediaUrl:(NSString*)mediaUrl ThumbnailData:(NSString*)thumbnailData MediaType:(NSString*)mediaType;
//
////func getAllMedia()
//-(NSString*) GetGroupAvtarWithMediaType:(NSString*)mediaType;
//
//-(void) updateMediaUrlWithMessageId:(NSString*)messageId MediaUrl:(NSString*)mediaUrl;
//
//-(NSArray*) getMediaWithMessageId:(NSString*)messageId;
//
//-(void) deleteMediaDataWithMessageId:(NSString*)messageId;
//
////-(void) getAllMedia;
//
//
//@end
