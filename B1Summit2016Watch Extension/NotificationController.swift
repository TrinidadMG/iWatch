//
//  NotificationController.swift
//  B1Summit2016Watch Extension
//
//  Created by Speidel, Duncan on 11/5/15.
//  Copyright © 2016 Speidel, Duncan. All rights reserved.
//

import WatchKit
import Foundation


class NotificationController: WKUserNotificationInterfaceController {

    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

  
    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a local notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        
        //MyDraft.draft = "In didReceiveLocalNotification"
        completionHandler(.Custom)
    }

    
    override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a remote notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        //This is for not active apps
        //4-11-2016 Fix for different format of APNs applied
        
        print ("In didReceiveRemoteNotification of NotificationController.swift")

        //let myTestItem:NSDictionary = (remoteNotification["aps"] as? [NSObject: AnyObject]!
        let apps = remoteNotification["aps"] as? [NSObject: AnyObject]
        let msg = apps!["alert"] as? NSDictionary
        var myAlert = NSString()
        if msg?.description != nil
        {
            print ("msg.description = ", msg!.description)
            myAlert = msg!.description
        }else{
            print ("In msg.description!= nill apps=", apps?.description)
            myAlert = (apps?.description)!
            print ("In else for msg !=nill myAlert=", myAlert)
        }

        myAlert = myAlert.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        myAlert = myAlert.stringByReplacingOccurrencesOfString("{", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("}", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString(";", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("\"", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("body = New approval request for sales order draft", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("alert: New approval request for sales order draft", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("\"", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("category: myCategory,", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString(":", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("[", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("]", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("badge 3", withString: "")
        //myAlert = myAlert.stringByReplacingOccurrencesOfString("alert = New approval request for sales order draft", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString(",", withString: "")
        myAlert = myAlert.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//        print ("After string replacement myAlert=", myAlert)
        //Dictionary object should capture just the alert but suspect some of the other text might be sneaking through
        
        ApprovalRequest = myAlert
        MyDraft.SavedData.SaveApprovalRequest = myAlert as String

        let interface = WKUserNotificationInterfaceType.Default
        
        completionHandler(interface)
        
        print ("\nAs we leave Notification Controller ApprovalRequest=", ApprovalRequest,"\n\nLeaving NotificationDidReceiveRemoteNotification\n\n")
    
    }//Close
 
    func handleNotification( alert : AnyObject? ){

        let myTestItem:NSDictionary = (alert!["aps"] as? NSDictionary!)!
        //print ("myTestItem =",myTestItem)
        var myAlert = myTestItem.description
        myAlert = myAlert.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        //print ("Just before myAlert processing MyAlert is ", myAlert)
        
        myAlert = myAlert.stringByReplacingOccurrencesOfString("alert = ", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("body = ", withString: "")
        //\"New approval request for sales order draft\"
        myAlert = myAlert.stringByReplacingOccurrencesOfString("\"", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("New approval request for sales order draft", withString: "")
        //body = New approval request for sales order draft
        
        myAlert = myAlert.stringByReplacingOccurrencesOfString("badge = 1;", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("category = myCategory;", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("sound = \"sound.caf\"", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("{", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("}", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("\"content-available\" = 1;", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString(";", withString: "")
        myAlert = myAlert.stringByReplacingOccurrencesOfString("\"", withString: "")
        myAlert = myAlert.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        MyDraft.SavedData.SaveApprovalRequest = myAlert.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        //print ("myAlert =",myAlert)
        print ("MyDraft.SavedData.SaveApprovalRequest", MyDraft.SavedData.SaveApprovalRequest)
            
        
        
    }//close handleNotification
    

    
}
