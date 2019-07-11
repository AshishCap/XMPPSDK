//
//  XMPPAppUtility.swift
//  XMPPNewSDK
//
//  Created by ashish on 7/4/19.
//  Copyright © 2019 Capanicus. All rights reserved.
//

import UIKit

@objcMembers
class XMPPAppUtility: NSObject
{
    /*--------- initiate shared manager   ------------*/
    @objc class var sharedInstance: XMPPAppUtility
    {
        struct Static
        {
            static let instance : XMPPAppUtility = XMPPAppUtility()
        }
        return Static.instance
    }
    
    func isNullOrEmpty(string: String) -> Bool
    {
        let trimmedString = string.trimmingCharacters(in: .whitespaces)
        return (trimmedString).isEmpty || trimmedString == "" || trimmedString.count == 0
    }
    
    /*---------------- Group checked --------------*/
    func isGroupMessageJid(jid: String) -> Bool
    {
        if jid.range(of:"@muclight.chat.goidd.com") != nil{
            return true
        }
        return false
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage
    {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height:  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x:0,y: 0,width: newSize.width,height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //------------- Save Audio / video data into directory file -----------------
    func saveFileToDocumentFolder(fileData: NSData , filename: String, folderName: String) -> String
    {
        //= FileHandle.init()
        let fileManager: FileManager = FileManager.default
        
        let path : String = NSHomeDirectory().appending(String.init(format: "/Documents/%@/",folderName )).appending(filename)
        let url: URL = URL.init(string: path)!
        
        fileManager.createFile(atPath: path, contents: nil, attributes: nil)
        do
        {
            let filehandler = try FileHandle.init(forWritingTo: url)
            filehandler.write(fileData as Data)
        }
        catch
        {
            
        }
        
        return path
    }
    
    func generateThumbnailImage(_ videoUrl:URL) -> UIImage {
        return Base64Conversion.generateThumbnail(url: videoUrl)
    }
    
    func getThumbnailDataOfImage(image: UIImage) -> String {
        return Base64Conversion.convertImageToBase64(image: image)
    }
    
    /*-------------- Save Directory folder -------------*/
    func saveImageToFolder(image1: UIImage , filename: String, folderName: String)
    {
        if let data = image1.jpegData(compressionQuality: 0.8)
        {
            var filehandler = FileHandle()
            let fileManager: FileManager = FileManager.default
            
            let path : String = NSHomeDirectory().appending(String.init(format: "/Documents/%@/",folderName )).appending(filename)
            fileManager.createFile(atPath: path, contents: nil, attributes: nil)
            filehandler = FileHandle.init(forWritingAtPath: path)!
            filehandler.write(data as Data)
        }
    }
    
    func returnRealGroupJidStr(jidStr: String) -> String {
        return jidStr.replacingOccurrences(of: xmppUserExt, with: xmppRoomExt)
    }
    
    func returnNumberFromJidStr(jidStr: String) -> String {
        let str: String = jidStr.replacingOccurrences(of: xmppUserExt, with: "")
        return str.replacingOccurrences(of: "@chat.goidd.com", with: "")
    }
    
    func getFormateDateAsperTimezone(localDate :NSDate , myTimeZone :TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = myTimeZone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFromString = dateFormatter .string(from: localDate as Date)
        return dateFromString
    }
    
    func getMyLocalTimeZone() -> TimeZone {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = "zzz"
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.timeZone as TimeZone
    }
    
    func getDateFormat(localDate :NSDate , myTimeZone :TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = myTimeZone
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateFromString = dateFormatter .string(from: localDate as Date)
        return dateFromString
    }
}

import Foundation
import AVFoundation
import CoreMedia

class Base64Conversion
{
    //
    // Convert String to base64
    //
    class func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    //
    // Convert base64 to String
    //
    class func convertBase64ToImage(imageString: String) -> UIImage {
        
        if let decodedData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) {
            return UIImage(data: decodedData)!
        }
        else
        {
            return UIImage()
            
        }
        
        
    }
    
    
    class func generateThumbnail(url: URL) -> UIImage {
        do {
            let asset = AVURLAsset(url: url)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imageGenerator.copyCGImage(at: CMTime.zero, actualTime: nil)
            
            return UIImage(cgImage: cgImage)
        } catch {
            print(error.localizedDescription)
            
            return UIImage()
        }
    }
    
}

extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        //let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let canvasSize = CGSize(width: width, height: width)
        
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
