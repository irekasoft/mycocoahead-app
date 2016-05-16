//
//  SavedEventsTableViewController.swift
//  Meetapp
//
//  Created by Hijazi on 15/5/16.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit
import CVCalendar
import RealmSwift

class SavedEventsTableViewController: UITableViewController {
  
  var events : Results<Event>!
  
  override func viewWillAppear(animated: Bool) {
    navigationController?.navigationBarHidden = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    tableView.registerNib(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "Cell")
    
    update(nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "update:", name: "favChanges", object: nil)
    
    
  }
  
  
  func update(notif: NSNotification?){
    
    print("update here")

    events = try! Realm().objects(Event).filter("isFavorited = true")
    tableView.reloadData()
    
  }
  
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return events.count
    }
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
      let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventCell
      let event = events[indexPath.row]
      
      cell.title.text = event.name
      cell.time.text = event.startTime.toString(format: .Custom("dd MMM yyyy h:mm a"))
    
      return cell
    }
  
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      return 65
    }
    
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    let controller = R.storyboard.main.eventDetails()!
    controller.event = events[indexPath.row]
    navigationController?.pushViewController(controller, animated: true)
  }
  
  
  
}
