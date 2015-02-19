//
//  ChatViewController.swift
//  Chat
//
//  Created by Isaac Ho on 2/18/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var messages = NSMutableArray()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        NSTimer.scheduledTimerWithTimeInterval( 2, target: self, selector: "onTimer", userInfo: nil, repeats: true )
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  messages.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.messagecell") as MessageCell
        
        cell.messageLabel.text = messages[ indexPath.row ] as String
        
        
        return cell
    }
    @IBAction func onCompose(sender: AnyObject) {
        
        
        var message = PFObject(className: "Message")
        message["text"] = messageTextField.text
        
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                println("Message saved!")
            } else {
                println("error with message!")
            }
        }
        
    }
    
    func onTimer()
    {
       var query=PFQuery(className: "Message")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("success: \(objects.count) obj received" )
                
                self.messages = NSMutableArray()
                
                for object in objects {
                    let x = (object as PFObject)
                    let text = x["text"] as String
                    println( "\(text)" )
                    
                    self.messages.addObject( text )
                }
                
                self.tableView.reloadData()
            }
        }
        
        
    }

}
