//
//  DeviceTableViewController.swift
//  SmartFriend
//
//  Created by Trinh Thai on 7/1/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit
import CoreData
//
class DeviceTableViewController: UITableViewController {
    
    //mảng time làm việc của các thiết bị hoặc cài đặt time hd cho người dùng
    var devices : [Device] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDevices()
    }
    
    // fetch dữ liệu từ CoreData
    func fetchDevices () {
        let fetchRequest : NSFetchRequest<Device> = Device.fetchRequest()
        do {
            let devices = try PersistenceService.context.fetch(fetchRequest)
            self.devices = devices
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Fetch Request failed.")
        }
    }
    
    //Button add
    @IBAction func plusButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add a new item", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Item Name"
        }
        createDeviceAlert(alert: alert, title: "Studying", viewController: self)
        createDeviceAlert(alert: alert, title: "Timework of machines", viewController: self)
        
        createDeviceAlert(alert: alert, title: "Doing exercise", viewController: self)
        createDeviceAlert(alert: alert, title: "Cooking", viewController: self)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            action in
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    //Lưu dữ liệu vào coredata và làm mới tableview
    func persistNewDevice(newDevice: Device) {
        self.devices.append(newDevice)
        PersistenceService.saveContext()
        self.tableView.reloadData()
    }
    
    // Đặt hình tương ứng với item đc tạo
    func createNewDevice(name: String, device: Device) {
        switch device {
        case device as Study:
            device.image = "hat"
        case device as Time:
            device.image = "machine"
        case device as Cook:
            device.image = "dog"
        case device as Exe:
            device.image = "do"
        default:
            print("Type of items does not exist!")
        }
        device.name = name
        persistNewDevice(newDevice: device)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    var a = ""
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! DeviceTableViewCell
        let device = devices[indexPath.row]
        cell.device = device
        
        return cell
    }
    
    
    //Link tới trang detail để cài đặt thời gian, all đều link tới 1 trang time
    var selectedDevice : Device?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = devices[indexPath.row]
        a=devices[indexPath.row].name!
        if device is Study {
            selectedDevice = device as! Study
            performSegue(withIdentifier: "ShowMicrowaveDetail", sender: nil)
        } else if device is Cook {
            selectedDevice = device as! Cook
            performSegue(withIdentifier: "ShowMicrowaveDetail", sender: nil)
        } else if device is Time {
            selectedDevice = device as! Time
            performSegue(withIdentifier: "ShowMicrowaveDetail", sender: nil)
        } else if device is Exe {
            selectedDevice = device as! Exe
            performSegue(withIdentifier: "ShowMicrowaveDetail", sender: nil)
        }
    }
    
    //chuyen sang trang chay thoi gian
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowMicrowaveDetail") {
            let deviceDetailVC = segue.destination as! TimeViewController
            deviceDetailVC.time = selectedDevice as? Time
            deviceDetailVC.title = a // them title
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // delete items sau khi đã confirm
        
        if indexPath.row < devices.count
        {
            let alert = UIAlertController(title: "Are you sure you want to delete \(devices[indexPath.row].name ?? "")?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: {(action) in
                let device = self.devices[indexPath.row]
                PersistenceService.context.delete(device)
                self.devices.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                PersistenceService.saveContext()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fetchDevices()
    }
    
}
