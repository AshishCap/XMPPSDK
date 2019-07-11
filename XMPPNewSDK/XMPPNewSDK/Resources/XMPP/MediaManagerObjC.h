//
//  MediaManagerObjC.h
//  XMPPNewSDK
//
//  Created by ashish on 7/10/19.
//  Copyright © 2019 Capanicus. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface MediaManagerObjC : NSObject

+ (MediaManagerObjC *) sharedManager;

-(void) saveMediaWithMessageId:(NSString*)messageId MediaUrl:(NSString*)mediaUrl ThumbnailData:(NSString*)thumbnailData MediaType:(NSString*)mediaType;

-(void) updateMediaWithMessageId:(NSString*)messageId MediaUrl:(NSString*)mediaUrl ThumbnailData:(NSString*)thumbnailData MediaType:(NSString*)mediaType;

//func getAllMedia()
-(NSString*) GetGroupAvtarWithMediaType:(NSString*)mediaType;

-(void) updateMediaUrlWithMessageId:(NSString*)messageId MediaUrl:(NSString*)mediaUrl;

-(NSArray*) getMediaWithMessageId:(NSString*)messageId;

-(void) deleteMediaDataWithMessageId:(NSString*)messageId;

//-(void) getAllMedia;


@end

//NS_ASSUME_NONNULL_END
