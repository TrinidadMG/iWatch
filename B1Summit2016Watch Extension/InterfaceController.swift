//
//  InterfaceController.swift
//  B1Summit2016Watch Extension
//  Created by Speidel, Duncan on 11/5/15.
//  Copyright © 2016 Speidel, Duncan. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import UIKit



/*struct MyDraft {
    
    static var draft = NSString()
    static var ApprovalRequest = NSString()
    static var remoteNotice = NSDictionary()
    // static var
    
    
}
 
 */

var ApprovalRequest = NSString()
var draft = String()

struct MyDraft{
    
    // Convenience variable for the standard defaults
    private static var Defaults: NSUserDefaults { return NSUserDefaults.standardUserDefaults() }
    
    struct SavedData {
        
        private static var draft = "savedDataArray"
        private static var ApprovalRequest = NSString()
        static var SaveDraft: [String] {
            get{
            return Defaults.objectForKey(draft) as? [String] ?? []
            }
        set {
        // This setter is called when the array contents change,
        // not just when a new array is set
        Defaults.setObject(newValue, forKey: draft)
        Defaults.synchronize()
        }
        }
        
  //      static var draft = NSString()
  //      static var ApprovalRequest = NSString()
        static var remoteNotice = NSDictionary()
        static var SaveApprovalRequest: String {
            get{
                return Defaults.objectForKey(ApprovalRequest as String) as! String
            }
            set {
                // This setter is called when the array contents change,
                // not just when a new array is set
                Defaults.setObject(newValue, forKey: ApprovalRequest as String)
                Defaults.synchronize()
            }
        }

        
    
    }//SaveData
} //Globals

var SL =  "http://54.191.40.200:50001/b1s/v1/" as String

var watchSession : WCSession?


class InterfaceController: WKInterfaceController {
    

    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        //didReceiveRemoteNotification(_userInfo: [NSObject : AnyObject])
        
        /*
         * Design change, switching to new input form
         */
        
        self.ProcessJavaScript()
        
        
        self.LogonServiceLayer()
        
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        /*
         * Thinking this might be called when app is active
         */
        self.ProcessJavaScript()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    /*
     * Screen controls here
     */


    @IBOutlet var CardNameLabel: WKInterfaceLabel!
    @IBOutlet var DocTotalLabel: WKInterfaceLabel!
    @IBOutlet var DiscountPerentageLabel: WKInterfaceLabel!
    @IBOutlet var CurrentAccountBalanceLabel: WKInterfaceLabel!
    @IBOutlet var SalesPersonLabel: WKInterfaceLabel!
    
    /*
     * Space below where we define functions for InterfaceController: WKInterfaceController
     */
    
    
    @IBAction func PressApprove() {
        print ("In Execute Approval")
        
        /*
        let SLurl = NSURL(string: "http://54.191.40.200:50001/b1s/v1/Login")
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:SLurl!)
        
        
        request.HTTPMethod = "POST"
        request.HTTPShouldHandleCookies=true //capture session ID
        request.timeoutInterval = 1740
        
        let bodyData = "{\"UserName\":\"manager\", \"Password\":\"1234\", \"CompanyDB\":\"SBODEMOUS\"}"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        request.HTTPMethod = "POST"
        
        let postString = "{\"UserName\":\"manager\", \"Password\":\"1234\", \"CompanyDB\":\"SBODEMOUS\"}"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            */
            
            //let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            self.ExecuteApproval()
        
        /*}
        task.resume()*/
        
    }//PressApproval
    
    func ExecuteApproval()
    {
        
        print("Calling ExecuteApprovalRequests")
        self.ExecuteApprovalRequests()
        print("Back from ExecuteApprovalRequests")
        
        let postString = "{\n\"ApprovalRequest\": { \n\"Code\":\(ApprovalRequest),\n\"ObjectType\":\"112\",\n\"IsDraft\":\"Y\",\n\"ObjectEntry\": 16,\n\"Status\": \"arsApproved\",\n\"Remarks\": \"ppp\",\n\"CurrentStage\": 7,\n\"OriginatorID\": 19,\n\"ApprovalRequestLines\": [\n{\n\"StageCode\": 7,\n\"UserID\": 1,\n\"Status\": \"arsApproved\",\n\"Remarks\": \"null\"\n}\n],\n\"ApprovalRequestDecisions\": [\n{\n\"ApproverUserName\": \"manager\",\n\"ApproverPassword\": \"1234\",\n\"Status\": \"ardApproved\",\n\"Remarks\": \"Approved and go ahead!\"\n}\n]\n}\n}"
        
        print ("In executeApproval PostString=", postString)
        
        
        //var SLurl = NSURL(string: "\(SL)ApprovalRequestsService_UpdateRequest")
        //var bodyData2 = "{\n\t\"ApprovalRequest\": { \n\t\"Code\":15,\n\t\"ObjectType\":\"112\",\n\t\"IsDraft\":\"Y\",\n\t\"ObjectEntry\": 16,\n\t\"Status\": \"arsApproved\",\n\t\"Remarks\": \"ppp\",\n\t\"CurrentStage\": 7,\n\t\"OriginatorID\": 19,\n\t\"ApprovalRequestLines\": [\n\t{\n\t\"StageCode\": 7,\n\t\"UserID\": 1,\n\t\"Status\": \"arsApproved\",\n\t\"Remarks\": \"ppp\"\n}\n],\n\"ApprovalRequestDecisions\": [\n{\n\"ApproverUserName\": \"manager\",\n\"ApproverPassword\": \"1234\",\n\"Status\": \"ardApproved\",\n\"Remarks\": \"Approved and go ahead!\"\n}\n]\n}\n}"
        
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "\(SL)ApprovalRequestsService_UpdateRequest")!)
        //var approvalStatus = NSData()
        
        //var serviceLayerResult = NSString()
        
        //let request:NSMutableURLRequest = NSMutableURLRequest(URL:SLurl!)
        
        request.HTTPMethod="POST"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            //let responseString = (response)?.copy()
            let httpResponse = response as! NSHTTPURLResponse
            
            if httpResponse.statusCode == 204
                
            {
                
                
                self.showPopup(0)
                
            } else {
                
                
                self.showPopup(1)
                
            }//close if
            
        }
        task.resume()
        
    } //close ExecuteApproval

    
    
  
    @IBAction func PressReject() {
        
        let SLurl = NSURL(string: "\(SL)/Login")
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:SLurl!)
        
        request.HTTPMethod = "POST"
        request.HTTPShouldHandleCookies=true //capture session ID
        request.timeoutInterval = 1740
        
        let bodyData = "{\"UserName\":\"manager\", \"Password\":\"1234\", \"CompanyDB\":\"SBODEMOUS\"}"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        request.HTTPMethod = "POST"
        
        let postString = "{\"UserName\":\"manager\", \"Password\":\"1234\", \"CompanyDB\":\"SBODEMOUS\"}"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            
            
            //let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            self.ExecuteReject (request)
        }
        task.resume()

    
    }//PressReject


    
    func ExecuteReject(request:NSMutableURLRequest)
        {
            //Before the approval can be executed need to first execute a draft get request
            print("In ExecuteReject calling ExecuteApprovalRequests")
            self.ExecuteApprovalRequests()
            print("In ExecuteReject back from ExecuteApprovalRequests")
            
            
            
            let postString = "{\n\"ApprovalRequest\": { \n\"Code\":\(ApprovalRequest),\n\"ObjectType\":\"112\",\n\"IsDraft\":\"Y\",\n\"ObjectEntry\": 16,\n\"Status\": \"arsNotApproved\",\n\"Remarks\": \"ppp\",\n\"CurrentStage\": 7,\n\"OriginatorID\": 19,\n\"ApprovalRequestLines\": [\n{\n\"StageCode\": 7,\n\"UserID\": 1,\n\"Status\": \"arsNotApproved\",\n\"Remarks\": \"null\"\n}\n],\n\"ApprovalRequestDecisions\": [\n{\n\"ApproverUserName\": \"manager\",\n\"ApproverPassword\": \"1234\",\n\"Status\": \"ardNotApproved\",\n\"Remarks\": \"Not Approved!\"\n}\n]\n}\n}"
            
            
            print ("\n\n In ExecuteReject PostString=", postString)
            
            let request = NSMutableURLRequest(URL: NSURL(string: "\(SL)ApprovalRequestsService_UpdateRequest")!)
            
            //var approvalStatus = NSData()
            
            //var serviceLayerResult = NSString()
            
            //let request:NSMutableURLRequest = NSMutableURLRequest(URL:SLurl!)
            
            request.HTTPMethod="POST"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                //let responseString = (response)?.copy()
                let httpResponse = response as! NSHTTPURLResponse
                
                if httpResponse.statusCode == 204
                    
                {
                    
                    
                    self.showPopup(2)
                    
                    
                    
                    
                } else {
                    
                    
                    self.showPopup(3)
                    
                }//close if
                
                
            }
            task.resume()
            
            
            
            
        }//OrderRejection
        
    
    
    func ExecuteApprovalRequests()
    {
        
        //Before the approval can be executed need to first execute a draft get request used by both approve and reject functions
        let draftRequest = NSMutableURLRequest(URL: NSURL(string: "\(SL)ApprovalRequests(\(ApprovalRequest))")!)
        draftRequest.HTTPMethod="GET"
        draftRequest.HTTPShouldHandleCookies = true
        draftRequest.timeoutInterval = 1740
        
        //print ("In Execute Approval we are calling:", draftRequest)
        
        let draftTask = NSURLSession.sharedSession().dataTaskWithRequest(draftRequest) {
            
            data, response, error in
            
            if error != nil {
                
                print("error=\(error)")
                
                return
                
            }
            
            
        }//draftTask
        
        draftTask.resume()
        
        
    }//ExecuteApprovalRequests
    
    /*
     * Cant't use UIAlertController in WatchKit so adding a pop-up function
     * Actually a little nicer thn what I found for ViewController
     * TODO: Determine if something similar exists for ViewController
     */
    func showPopup(message:Int){
        
        let h0 = { print("ok")
            exit(0)
        }
        
        let action1 = WKAlertAction(title: "Ok", style: .Default, handler:h0)
        //let action2 = WKAlertAction(title: "Decline", style: .Destructive) {}
        //let action3 = WKAlertAction(title: "Cancel", style: .Cancel) {}
        
        //presentAlertControllerWithTitle("Voila", message: "", preferredStyle: .ActionSheet, actions: [action1, action2,action3])
        if message == 0
        {
            presentAlertControllerWithTitle("Order Approved", message: "", preferredStyle: .ActionSheet, actions: [action1])

            
        } else if message == 1 {
            presentAlertControllerWithTitle("Order Approval failed", message: "", preferredStyle: .ActionSheet, actions: [action1])
            
        }else if message == 2 {
            presentAlertControllerWithTitle("Order Cancelled", message: "", preferredStyle: .ActionSheet, actions: [action1])
            
        }else if message == 3 {
            presentAlertControllerWithTitle("Order Cancellation failed", message: "", preferredStyle: .ActionSheet, actions: [action1])
        }
        
        
    }//showPopup
    
    /*
     *
     * Empty comment as placehold for later
     *
     */
    
    func ProcessJavaScript()
    {
        print ("In Process JavaScript ApprovalReques = ", ApprovalRequest)
        
        
        var B1APNXSJS = NSURL()
        
        if ApprovalRequest.length == 0
        {
            print("Assigning default value, 432, to ApprovalRequest and 428 to draft")
            print ("\n\n\n*******In default value MyDraft.SavedData.ApprovalRequest =",MyDraft.SavedData.ApprovalRequest)
            
            /*
             * App should only be stared via APN but if started manually you should see results
             */
            ApprovalRequest = "443"
            draft = "439"
        }

        B1APNXSJS = NSURL(string: "http://54.191.40.200:8000/B1APN/services.xsodata/DocumentDetails?$format=json&$filter=WddCode%20eq%20\(ApprovalRequest)&$select=CardName,DocTotal,DiscPrcnt,Balance,SlpName")!
        
        let xsjsRequest:NSMutableURLRequest = NSMutableURLRequest(URL:B1APNXSJS)
        xsjsRequest.timeoutInterval = 1740
        xsjsRequest.HTTPShouldHandleCookies = true
        
        /*
         * Create JSON Variables
         */
/*        var err: NSError?
        var CardName = "Parameter Technolgy........"
        var DocTotal = 999999999.99
        var DiscPrcnt = 100.00
        var Balance = 9999999999.99
        var SLPName = "Duncan Brady Speidel"
        
        let params:[String: AnyObject] = [
        "Customer" : CardName,
        "Amount" : DocTotal,
        "Special Discount" : DiscPrcnt,
        "Balance": Balance,
        "by": SLPName]
 */
        
        //xsjsRequest.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(xsjsRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            var JSONInput = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print ("JSONInput=",JSONInput)
            self.ParseJSON(JSONInput!)

        }//let task
        task.resume()
 
 
    }//ProcessJavaScript
    
    func ParseJSON(JSON:NSString)
    {
        print ("\n\n\nIn ParseJSON JSON = ", JSON)
        /*
         * TODO Switch toi proepr JSON formating
         *
         */
        var localJSON = JSON.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        localJSON = localJSON.stringByReplacingOccurrencesOfString("{", withString: "")
        localJSON = localJSON.stringByReplacingOccurrencesOfString("}", withString: "")
        //localJSON = localJSON.stringByReplacingOccurrencesOfString("\"d\"", withString: "")
        localJSON = JSON.stringByReplacingOccurrencesOfString("results\":[{\"__metadata\": {\"type\":\"B1APN.services.DocumentDetailsType\",\"uri\":\"http://54.191.40.200:8000/B1APN/services.xsodata/", withString: "")
        localJSON = localJSON.stringByReplacingOccurrencesOfString("\"", withString: "")
        localJSON = localJSON.stringByReplacingOccurrencesOfString("d:", withString: "")
        //{{DocumentDetails(433)},
        localJSON = localJSON.stringByReplacingOccurrencesOfString("{{DocumentDetails(\(ApprovalRequest))},", withString: "")
        localJSON = localJSON.stringByReplacingOccurrencesOfString("}]}}", withString: "")
        localJSON = localJSON.stringByReplacingOccurrencesOfString(":", withString: " ")
        
        //print("localJSON=", localJSON)

        
        var writeOut=true
        var isComma=false
        var fieldCount = 0
        var CardName = String()
        var SlpName = String()
        var DocTotal = String() //field 2
        var DiscountPercentage = String()
        var Balance = String()
        
        //for item in localString.characters
        for item in localJSON.characters
        {
            //print(item)
            if (item == "," )
            {
                //print ("In item==, if")
                writeOut=false
                isComma=true
                fieldCount += 1
                
            }//item = comma if
            //writeOut && !isComma && fieldCount==1
            if writeOut && !isComma && fieldCount==0
                
            {
                CardName = CardName + String (item)
            }else if !isComma && fieldCount==1{
                
                SlpName = SlpName + String (item)
            }else if !isComma && fieldCount==2 {
                Balance = Balance + String (item)
            }else if !isComma && fieldCount==3 {
                DocTotal = DocTotal + String (item)
            }else if !isComma && fieldCount==4 {
             DiscountPercentage = DiscountPercentage + String (item)
            }
            //writeOut=true
            isComma=false
            
        }//for
        

        
        CardName = CardName.stringByReplacingOccurrencesOfString("CardName", withString: "Customer:")
        SlpName = SlpName.stringByReplacingOccurrencesOfString("SlpName", withString: "Sales Employee:")
        Balance = Balance.stringByReplacingOccurrencesOfString("Balance", withString: "bal:")
        DocTotal = DocTotal.stringByReplacingOccurrencesOfString("DocTotal", withString: "Amount:")
        DiscountPercentage = DiscountPercentage.stringByReplacingOccurrencesOfString("DiscPrcnt", withString: "Special Discount:")
        
/*
 *Debug statements
 
        print ("CardName=", CardName)
        print("SlpName=", SlpName)
        print("balace=", Balance)
        print("DocTotal=", DocTotal)
        print("Discount%=", DiscountPercentage)
*/        
        CardNameLabel.setText((CardName))
        DocTotalLabel.setText(DocTotal)
        DiscountPerentageLabel.setText(DiscountPercentage)
        CurrentAccountBalanceLabel.setText(Balance)
        SalesPersonLabel.setText(SlpName)
        
        
        
    }//ParseSJON
    
    func LogonServiceLayer(){
        
        let SLurl = NSURL(string: "\(SL)/Login")
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:SLurl!)
        let postString = "{\"UserName\":\"manager\", \"Password\":\"1234\", \"CompanyDB\":\"SBODEMOUS\"}"


        request.HTTPMethod = "POST"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPShouldHandleCookies = true //capture session ID
        request.timeoutInterval=1750 //29 minutes
        
        //
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
        }
        task.resume()
        
        print ("Login executed")
        
    }//LogonServiceLayer
    
    func GetDraftNumber (request:NSMutableURLRequest) {
        /*
         * APN passes DocEntry we need that later for approval but firs need draft number to get draft details
         * Will use /b1s/v1/ApprovalRequests(357) to get draft number
         */
        //let request = NSMutableURLRequest(URL: NSURL(string: "\(SL)Login")!)
        let SLLogonReguest = request
        
        /*
         * If app starts without an APN must do something to prevent a crash so hardcoding a dummy doc
         */
        
        if ApprovalRequest.length == 0
        {
            print("Assigning default value, 432, to ApprovalRequest and 428 to draft")
            print ("\n\n\n*******In default value MyDraft.SavedData.ApprovalRequest =",MyDraft.SavedData.ApprovalRequest)
            
            /*
             * asyncrhonous calls below and if GetDraftDetails is called before let draftTask = NSURLSession.sharedSession().dataTaskWithRequest(draftRequest) is 
             * finished bad things happen.  Default comapny = maxi-tech
             */
            ApprovalRequest = "432"
            draft = "428"
        }
        
        
        let draftRequest = NSMutableURLRequest(URL: NSURL(string: "\(SL)ApprovalRequests(\(ApprovalRequest))?$select=ObjectEntry")!)
        
        draftRequest.HTTPMethod="GET"
        draftRequest.HTTPShouldHandleCookies = true
        draftRequest.timeoutInterval = 1740
        
        let draftTask = NSURLSession.sharedSession().dataTaskWithRequest(draftRequest) {
            
            data, response, error in
            
            if error != nil {
                
                print("error=\(error)")
                
                return
                
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            
            responseString = responseString!.stringByReplacingOccurrencesOfString("\(SL)$metadata#ApprovalRequests/@Element\",", withString: "")
            responseString = responseString!.stringByReplacingOccurrencesOfString("\"odata.metadata\" : \"", withString: "")
            //responseString = responseString!.stringByReplacingOccurrencesOfString("$metadata#ApprovalRequests/@Element\",", withString: "")
            responseString = responseString!.stringByReplacingOccurrencesOfString("\"ObjectEntry\" :", withString: "")
            responseString = responseString!.stringByReplacingOccurrencesOfString("{", withString: "")
            responseString = responseString!.stringByReplacingOccurrencesOfString("}", withString: "")
            responseString = responseString!.stringByReplacingOccurrencesOfString("(", withString: "")
            responseString = responseString!.stringByReplacingOccurrencesOfString(")", withString: "")
            responseString = responseString!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            //print("responseString=", responseString)
            
            draft = responseString!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            print ("draft in GetDraftNumber = ", draft)
            self.GetDraftDetails(SLLogonReguest)
        }//web call
        
        draftTask.resume()
        
        print ("In GetDraftNumber draft =", draft)
        //self.GetDraftDetails(SLLogonReguest)
        
    }//GetDraftNumber
    func GetDraftDetails(request:NSMutableURLRequest) {
        
        /*
         
         * Reset variable used above to get the order new URL is:
         
         * \(SL)?$select=CardName,DocTotal,DiscountPercent" Done via GET
         
         */
        
        var SLurl = NSURL()
        print ("GetDraftDetails draft=",draft)

        print ("GetDraftDetails SLurl will =\(SL)Drafts(\(draft))?$select=CardName,DocTotal,DiscountPercent")
        SLurl = NSURL(string: "\(SL)Drafts(\(draft))?$select=CardName,DocTotal,DiscountPercent")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:SLurl)
        request.HTTPShouldHandleCookies = true
        request.HTTPMethod = "GET"
        request.timeoutInterval = 1740 //29 minutes
        var orderDetails = NSString()
        /*
         
         * Call SL Drafts and get the order we received notice about
         
         */
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            orderDetails = responseString!
            let CardName = self.GetOrderDetails(orderDetails)
            self.GetBPDetails(request, CardName: CardName)
        }
        task.resume()
        
    }//Close GetDraftDetails
    
    func GetOrderDetails(orderDetails: NSString) -> String{
        
        var writeOut=false
        
        //let <#name#> = <#value#>
        
        let localString = orderDetails as String
        
        var isComma=true
        
        var fieldCount = 0;
        
        var CardName = String()
        
        var DocTotal = String() //field 2
        
        var DiscountPercentage = String()
        
        
        for item in localString.characters
            
        {
            
            if (item == "," )
                
            {
                
                //testString = testString + String (item)
                
                writeOut=true
                
                isComma=true
                
                fieldCount = fieldCount + 1
                
                
            }//item = comma if
            
            if writeOut && !isComma && fieldCount==1
                
            {
                
                CardName = CardName + String (item)
                
            }else if !isComma && fieldCount==2 {
                
                DocTotal = DocTotal + String (item)
                
                
                
            }else if !isComma && fieldCount==3 {
                
                DiscountPercentage = DiscountPercentage + String (item)
                
            }
            
            isComma=false
            
            
            
        }//for
        
        
        CardName = CardName.stringByReplacingOccurrencesOfString("\"", withString: "")
        CardName = CardName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        CardName = CardName.stringByReplacingOccurrencesOfString("CardName", withString: "Customer")
        CardName = CardName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        
        CardNameLabel.setText((CardName))
        DocTotal = DocTotal.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        if (DocTotal.rangeOfString(".0") != nil)
        {
            DocTotal = DocTotal.stringByReplacingOccurrencesOfString(".0", withString: "")
        }else{
            DocTotal = DocTotal.substringToIndex(DocTotal.endIndex.predecessor())
        }
        
        DocTotal = DocTotal.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        /*
         * Discovered the service layer called used to get DocTotal pads the end of the field with a 9's
         * No time to investigate why 676.56 is shown here as 676.55999999999 so wrote for below to only show 2 digits
         * If you find a more elegant solution please share it
         */
        if (DocTotal.rangeOfString(".") != nil)
        {
            
            var charCount = 0
            var decimalFound = false
            var cleanDocTotal = String()
            var firstPass = 0
            
            
            for item in DocTotal.characters
            {
                if (item == ".")
                {
                    charCount += 1
                    decimalFound = true
                    cleanDocTotal = cleanDocTotal + String(item)
                    firstPass = 1
                }else{
                    cleanDocTotal = cleanDocTotal + String(item)
                    if (decimalFound) && (firstPass  != 0)
                    {
                        charCount += 1
                    }
                    
                }
                
                if (charCount>=3)
                {
                    DocTotal=cleanDocTotal
                    break
                }
                
            }//for to remove extra decimal points
        }//check for a decimal
        
        
        DocTotal = DocTotal.stringByReplacingOccurrencesOfString("DocTotal", withString: "Amount")
        
        DocTotalLabel.setText(DocTotal)
        
        DiscountPercentage = DiscountPercentage.stringByReplacingOccurrencesOfString("\"", withString: "")
        DiscountPercentage = DiscountPercentage.stringByReplacingOccurrencesOfString("}", withString: "")
        DiscountPercentage = DiscountPercentage.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        //DiscountPercentage = DiscountPercentage.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        DiscountPercentage = DiscountPercentage.stringByReplacingOccurrencesOfString("DiscountPercent", withString: "Special Discount")
        if DiscountPercentage.rangeOfString("0.0") != nil
        {
            //turn 0.0 inot 0
            
            DiscountPercentage = DiscountPercentage.stringByReplacingOccurrencesOfString(".0", withString: "")
            DiscountPerentageLabel.setText(DiscountPercentage)
            
        }else{
            DiscountPerentageLabel.setText(DiscountPercentage)
        }
        
        return CardName
        
        
    }//GetOrderDetails
    
    func GetBPDetails(request:NSMutableURLRequest, CardName:String)
        
    {
        
        /*
         
         * Use request object to call SL BP
         
         * Will filter BP to one passed to use from calling function
         
         * Will confirm all parameters before executing call
         
         */
        

        var fixedCardName = CardName.stringByReplacingOccurrencesOfString("CardName", withString:"", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        
        fixedCardName = CardName.stringByReplacingOccurrencesOfString("Customer : ", withString:"", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        //fixedCardName = fixedCardName.stringByReplacingOccurrencesOfString(":", withString:"", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        fixedCardName = fixedCardName.stringByReplacingOccurrencesOfString("\"", withString:"'", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        fixedCardName = fixedCardName.stringByReplacingOccurrencesOfString("  ", withString: "")
        
        
        fixedCardName = fixedCardName.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        
        
        //$select=CardName,DocTotal,DiscountPercent,DocNum,SalesPerson/SalesEmployeeName&$expand=SalesPerson
        
        
        let SLurl = NSURL(string: "\(SL)BusinessPartners?$filter=CardName%20eq%20'\(fixedCardName)'&$select=CurrentAccountBalance,CreditLimit,SalesPerson/SalesEmployeeName&$expand=SalesPerson")
        
        
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:SLurl!)
        
        request.HTTPMethod = "GET"
        request.HTTPShouldHandleCookies = true
        request.timeoutInterval = 1740
        
        var bpDetails = NSString()
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            
            data, response, error in
            
            
            
            if error != nil {
                
                print("error=\(error)")
                
                return
                
            }
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            bpDetails = responseString!
            
            self.GetBPInfo(bpDetails)
        }
        task.resume()
        
    } //GetBPDetails
    
    
    func GetBPInfo(bpDetails: NSString)
        
    {
        
        var writeOut=false
        
        var localString = bpDetails as String
        
        var isComma=true
        
        var fieldCount = 0
        
        var creditLimit = String ()
        
        var currentAccountBalance = String ()
        
        var salesPersonName = String()
        
        var salesPass = 0
        
        
        
        /*
         
         * Remove extra character sequences added by service layer
         
         */
        
        localString = localString.stringByReplacingOccurrencesOfString("\"odata.metadata\" : \"http://54.191.40.200:50001/b1s/v1/$metadata#BusinessPartners\",",withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        localString = localString.stringByReplacingOccurrencesOfString("{",withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        localString = localString.stringByReplacingOccurrencesOfString("}",withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        localString = localString.stringByReplacingOccurrencesOfString("[",withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        localString = localString.stringByReplacingOccurrencesOfString("]",withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        localString = localString.stringByReplacingOccurrencesOfString("{",withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        localString = localString.stringByReplacingOccurrencesOfString("\"value\"",withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        localString = localString.stringByReplacingOccurrencesOfString("SalesPerson",withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        
        
        
        for item in localString.characters
            
        {
            
            if item == "\""
                
            {
                
                writeOut = true
                
            }
            
            if fieldCount == 0
                
            {
                
                fieldCount = fieldCount + 1
                
            }
            
            if item == ","
                
            {
                
                fieldCount = fieldCount + 1
                
                isComma = true
                
                writeOut=false
                
            }
            
            
            if writeOut && !isComma && fieldCount==1
                
            {
                
                //Need to skip first : keep rest, better way to do buit no time to find
                
                if salesPass != 3
                    
                {
                    
                    salesPersonName = salesPersonName + String(item)
                    
                    
                }
                
                salesPass += 1
                
            }else if !isComma && fieldCount==2
                
            {
                
                creditLimit = creditLimit + String(item)
                
                
                
            }else if !isComma && fieldCount==3
                
            {
                
                currentAccountBalance = currentAccountBalance + String (item)
                
                
            }
            
            isComma = false
            
            
        }//for
        
        
        
        /*
         
         * Built CreditLimit and AccountBalnce fields now need to show them on device
         
         */
        
        creditLimit = creditLimit.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        creditLimit = creditLimit.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        /*
         * For spacing I dropped creditLimit if it comes back this is where it gets assigned to the label
         CreditLimit.SetText (creditLimit)
         */
        currentAccountBalance = currentAccountBalance.stringByReplacingOccurrencesOfString("\"", withString: "")
        currentAccountBalance = currentAccountBalance.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        /*
         if (DocTotal.rangeOfString(".0") != nil)
         {
         DocTotal = DocTotal.stringByReplacingOccurrencesOfString(".0", withString: "")
         }else{
         DocTotal = DocTotal.substringToIndex(DocTotal.endIndex.predecessor())
         }
         
         
         */
        if (currentAccountBalance.rangeOfString(".0") != nil)
        {
            currentAccountBalance = currentAccountBalance.stringByReplacingOccurrencesOfString(".0", withString: "")
            
        }else{
            currentAccountBalance = currentAccountBalance.substringToIndex(currentAccountBalance.endIndex.predecessor())
        }
        
        currentAccountBalance = currentAccountBalance.stringByReplacingOccurrencesOfString("CurrentAccountBalance", withString: "Bal: ")
        CurrentAccountBalanceLabel.setText(currentAccountBalance)
        
        salesPersonName = salesPersonName.stringByReplacingOccurrencesOfString("\"", withString: "")
        salesPersonName = salesPersonName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        salesPersonName = salesPersonName.stringByReplacingOccurrencesOfString("SalesEmployeeName", withString: "By: ")
        
        SalesPersonLabel.setText(salesPersonName)
        
    }//GetBPInfo
    
}//InterfaceController: WKInterfaceController
