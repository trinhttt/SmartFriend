//
//  ViewController.swift
//  SmartFriend
//
//  Created by Trinh Thai on 7/1/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()    }
}
extension UIViewController {
    
    func fireAlert(title: String, confirmationTitle: String) {
        
        // Chức năng hiện alert khi hết thời gian
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: confirmationTitle, style: .default, handler: nil)
        alert.addAction(confirm)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func fireNotification(title: String, body: String) {
        
        // Chức năng kích hoạt thông báo khi hết thời gian
        let content = UNMutableNotificationContent()// là 1 kiểu đối tượng của UNNotificationRequest
        content.title = title
        content.body = body
        content.badge = 1
        content.sound = UNNotificationSound.default()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    //Hàm yêu cầu người dùng cho phép hiện thông báo và âm thanh
    func askForNotificationPermission () {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
    }
}

extension String {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension DeviceTableViewController {
    
    func createDeviceAlert(alert: UIAlertController ,title: String, viewController: DeviceTableViewController) {
        alert.addAction(UIAlertAction(title: title, style: .default, handler: {(action) in
            // alert cho phép tạo
            let name = alert.textFields?.first!.text!
            if (name?.isBlank)! {
                viewController.showEmptyNameAlert(viewController: self)
            } else {
                let device : Device
                switch title {
                // tạo 1 dòng công việc cần set time mới
                case "Studying": device = Study(context: PersistenceService.context)
                case "Timework of machines": device = Time(context: PersistenceService.context)
                case "Doing exercise": device = Exe(context: PersistenceService.context)
                case "Cooking": device = Cook(context: PersistenceService.context)
                default:
                    print("Something went wrong!")
                    device = Time(context: PersistenceService.context)
                }
                viewController.createNewDevice(name: name!, device: device)
            }
        }))
    }
    
    //Không nhập tên không cho tạo dòng mới
    func showEmptyNameAlert(viewController: DeviceTableViewController) {
        let emptyStringAlert = UIAlertController(title: "Adding a new item has failed", message: "Please enter a name.", preferredStyle: .alert)
        emptyStringAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {
            (action) in
            viewController.plusButtonPressed(emptyStringAlert)
        }))
        self.present(emptyStringAlert, animated: true, completion: nil)
    }
}

