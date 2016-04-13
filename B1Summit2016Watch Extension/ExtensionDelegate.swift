//
//  ExtensionDelegate.swift
//  B1Summit2016Watch Extension
//
//  Created by Speidel, Duncan on 11/5/15.
//  Copyright © 2015 Li, Yatsea. All rights reserved.
//

import WatchKit
import UIKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
    }
    


    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func didReceiveRemoteNotification(_userInfo: [NSObject : AnyObject]){
        /*
         * Used to unbundle the NSDictonary object that we receive from APN 
         * Called when app active
         */
        
        
        print("In Extension Delegate didReceiveRemoteNotification")
        
        if let aps = _userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                if let message = alert["message"] as? NSString {
                    //Do stuff
                    var draftNum = alert.description
                    draftNum = draftNum.stringByReplacingOccurrencesOfString("New approval request for sales order draft", withString: "")
                    
                    MyDraft.SavedData.SaveApprovalRequest = draftNum.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                    ApprovalRequest = draftNum
                    print ("Message =", message)
                }
            } else if let alert = aps["alert"] as? NSString {
                
                let draftNum = alert.stringByReplacingOccurrencesOfString("New approval request for sales order draft", withString: "")
                
                MyDraft.SavedData.SaveApprovalRequest=draftNum.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                
            }
        }

        
  /*
   * Original alert unpacking
 
        
        let apps = _userInfo["aps"] as? [NSObject: AnyObject]
        print ("apps =", apps)
        print ("Setting msg")
        let msg = apps!["alert"] as? NSDictionary
            print ("Creating myAlert")
        
            var myAlert = NSString()

        myAlert = msg!.description
        print ("Here")
        myAlert = myAlert.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        myAlert = myAlert.stringByReplacingOccurrencesOfString("{", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("}", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString(";", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("\"", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("body = New approval request for sales order draft", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("\"", withString: "")
        myAlert = myAlert.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        //Dictionary object should capture just the alert but suspect some of the other text might be sneaking through
        
        ApprovalRequest = myAlert
        MyDraft.SavedData.SaveApprovalRequest = myAlert as String

   */      
        print("In Extension Delegate didReceiveRemoteNotification MyDraft.ApprovalRequest=", MyDraft.SavedData.SaveApprovalRequest)
        print("In Extension Delegate didReceiveRemoteNotification ApprovalRequest=", ApprovalRequest)
 
 
         print ("In ExtensionDelegate MyDraft.ApprovalRequest=",MyDraft.SavedData.SaveApprovalRequest)
            
        
    } //DidReceiveRemoteNotification
  

    
}
