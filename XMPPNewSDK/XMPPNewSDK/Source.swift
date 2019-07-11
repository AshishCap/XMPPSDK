//
//  Source.swift
//  XMPPNewSDK
//
//  Created by ashish on 5/30/19.
//  Copyright © 2019 Capanicus. All rights reserved.
//

import Foundation
import XMPPFramework

public class Service
{
    private init() {}
    
    public static func FirstMethod() -> String
    {
        return "Project is working"
    }
    
    public static func LoginAndAuthenticateWith(username: String, password: String)
    {
        XMPPConnectionManager.shared()?.authenticateUserWIthUSerName(username, withPassword: password)
    }
    
    public static func SendPresenceTo(jidString: String)
    {
        XMPPConnectionManager.shared().sendSubscribeMessage(toUser: jidString)
        
        /*------------- Presence user -----------*/
        let jid : XMPPJID = XMPPJID(string: jidString)!
        let presence :  XMPPPresence = XMPPPresence.init(type: "available", to: jid)
        XMPPConnectionManager.shared().xmppStream .send(presence)
    }
    
    public static func SendChatMessage(message: String, jidString: String)
    {
        if !XMPPAppUtility.sharedInstance.isNullOrEmpty(string: message)
        {
            let trimmedString = message.trimmingCharacters(in: .whitespacesAndNewlines)
            let messageId = XMPPConnectionManager.shared().xmppStream.generateUUID
            
            let message : XMPPMessage = XMPPConnectionManager.shared().getXmppMessage(jidString, withContents: trimmedString, messageid: messageId)
            
            XMPPUserManager.shared().customArchiveMessage(message, outgoing: true, xmppStream: XMPPConnectionManager.shared().xmppStream)
            
            XMPPConnectionManager.shared().send(message)
        }
    }
    
    public static func DeleteChatMessage(messageId: String)
    {
        XMPPUserManager.shared().xmppMessageArchivingCoreDataStorage.deleteMessage(messageId)
    }
    
    public static func DeleteAllMessageFor(user: String, groupName: String)
    {
        XMPPUserManager.shared().xmppMessageArchivingCoreDataStorage.clearAllMessage(user, isAllMessages: false)
        XMPPUserManager.shared().xmppMessageArchivingCoreDataStorage.deleteAndExitChatRoom(user, isAllRooms: false)
        if XMPPAppUtility.sharedInstance.isGroupMessageJid(jid: user)
        {
            XMPPConnectionManager.shared().leaveXmppRoom(user, roomName: groupName)
        }
    }
    
    public static func CreateGroupWith(name: String, users: [String]/*NSMutableArray*/)
    {
        var usersForRoom = Set<XMPPJID>()
        for contacts in users
        {
            let contact = contacts
            //print("contact.userJID -> \(contact.userJID!)")
            let jid : XMPPJID = XMPPJID(string:String(format:"%@%@",contact, xmppUserExt))!
            usersForRoom.insert(jid)
        }
        addRoom(withName: name, initialOccupantJids: Array(usersForRoom))
    }
    
    public static func addRoom(withName roomName: String, initialOccupantJids: [XMPPJID]?)
    {
        let addedRoom = XMPPRoomLight(jid: XMPPJID(string: "muclight.chat.goidd.com")!, roomname: roomName)
        addedRoom.addDelegate(XMPPConnectionManager.shared()!, delegateQueue: DispatchQueue.main)
        addedRoom.activate(XMPPConnectionManager.shared().xmppStream)
        addedRoom.createRoomLight(withMembersJID: initialOccupantJids)
        addedRoom.addUsers(initialOccupantJids!)
    }
}

