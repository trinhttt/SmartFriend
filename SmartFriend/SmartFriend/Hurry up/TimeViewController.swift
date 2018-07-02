//
//  TimeViewController.swift
//  SmartFriend
//
//  Created by Trinh Thai on 7/1/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
////

import UIKit
import UserNotifications

//Màn hình cài đặt thời gian
class TimeViewController: UIViewController {
    
    var time : Time?//1 dòng của table view cài đặt thời gian chờ
    var timer = Timer()
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var microwaveModeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var timerPicker: UIPickerView!
    @IBOutlet weak var microwaveButton: UIButton!
    @IBOutlet weak var remainingTime: UILabel!
    @IBOutlet weak var cancelTimerButton: UIButton!
    @IBOutlet weak var heatingLabel: UILabel!
    let onString = "Time-setting  is on."// trạng thái bậc của timerPicker
    let offString = "Time-setting is off."
    var minutes: Int = 0
    var seconds: Int = 0
    var aa = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        aa = self.title!
        //Load timerPicker
        timerPicker.delegate = self
        timerPicker.dataSource = self
        
        // Cài đặt thời gian mặc định cho timer picker
        if time?.status == true {
            statusSwitch.isOn = true
            statusLabel.text = onString
            toggleInteractionOn()
            if timer.isValid {
                showTimer()
            }
        } else {
            statusSwitch.isOn = false
            statusLabel.text = offString
            toggleInteractionOff()
        }
        
        // Khi chọn lại mục mức độ khẩn trương của công việc với thời gian hiện tại -> gọi hàm
        switch time?.mode {
        case "High"?:
            microwaveModeSegmentedControl.selectedSegmentIndex = 0
        case "Normal"?:
            microwaveModeSegmentedControl.selectedSegmentIndex = 1
        case "Week"?:
            microwaveModeSegmentedControl.selectedSegmentIndex = 2
        default:
            print("Illegal value for Time.mode: \(time?.mode ?? "nil")")
        }
        loadBarButtons()//cập nhật buttons
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadBarButtons()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.popViewController(animated: false)
    }
    
    
    //Bắt đầu chạy thời gian đã cài đặt
    @IBAction func startMicrowavingAction(_ sender: UIButton) {
        askForNotificationPermission()
        
        //Nếu số giây từ 1 đến 9 thì thêm '0' vào
        if seconds < 10 {
            remainingTime.text = "\(minutes):0\(seconds)"
        } else {
            remainingTime.text = "\(minutes):\(seconds)"
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (self.counter), userInfo: nil, repeats: true)
        showTimer()
    }
    
    @objc func counter () {
        seconds -= 1
        
        //Chạy hết thời gian cài đặt, thông báo sẽ hiện lên
        if seconds <= 0 && minutes <= 0 {
            
            //Hiện lên thông báo Timeout đang ở background
            if UIApplication.shared.applicationState == .background {
                fireNotification(title: "\(aa )", body: ": timeout!")
            } else {
                //Hiện lên thông báo Timeout đang ở ngay trong đó
                fireAlert(title: " \((aa ) ): timeout!", confirmationTitle: "Confirm")
            }
            timer.invalidate()
            exitTimer()
            return
        }
        seconds < 10 ? (remainingTime.text = "\(minutes):0\(seconds)") : (remainingTime.text = "\(minutes):\(seconds)")
        if seconds == 0 {
            minutes -= 1
            seconds = 60
        }
    }
    
    func exitTimer() {
        // Trả lại giá trị ban đầu và trạng thái off của timerPicker và button
        minutes = timerPicker.selectedRow(inComponent: 0)
        seconds = timerPicker.selectedRow(inComponent: 1)
        remainingTime.isHidden = true
        cancelTimerButton.isHidden = true
        heatingLabel.isHidden = true
        timerPicker.isHidden = false
        microwaveButton.isHidden = false
    }
    
    @IBAction func cancelTimerAction(_ sender: UIButton) {
        timer.invalidate()
        exitTimer()
    }
    
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            time?.status = true
            statusLabel.text = onString
            toggleInteractionOn()
        } else {
            time?.status = false
            statusLabel.text = offString
            toggleInteractionOff()
            if timer.isValid {
                timer.invalidate()
            }
            exitTimer()
        }
        PersistenceService.saveContext()
    }
    
    // Hàm set mức độ khẩn trương của công việc với thời gian hiện tại
    @IBAction func microwaveModeSegControlAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            time?.mode = "High"
        case 1:
            time?.mode = "Normal"
        case 2:
            time?.mode = "Week"
        default:
            print("Non-Existing Index: \(sender.selectedSegmentIndex) selected.")
        }
        PersistenceService.saveContext()
    }
    
    // UI cài đặt show thời gian
    func showTimer() {
        timerPicker.isHidden = true
        microwaveButton.isHidden = true
        cancelTimerButton.isHidden = false
        remainingTime.isHidden = false
        heatingLabel.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Khi bật toggle
    func toggleInteractionOn (){
        microwaveModeSegmentedControl.isEnabled = true
        timerPicker.isUserInteractionEnabled = true
        microwaveButton.isEnabled = true
    }
    
    // Khi tắt toggle
    func toggleInteractionOff (){
        microwaveModeSegmentedControl.isEnabled = false
        timerPicker.isUserInteractionEnabled = false
        microwaveButton.isEnabled = false
    }
    
}
extension TimeViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            minutes = row
        case 1:
            seconds = row
        default:
            break;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        // Shows white-colored strings in both components while considering singular and plural
        switch component {
        case 0:
            if row == 1 {
                return NSAttributedString(string: "\(row) Minute", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
            } else {
                return NSAttributedString(string: "\(row) Minutes", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
            }
        case 1:
            if row == 1 {
                return NSAttributedString(string: "\(row) Second", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
            } else {
                return NSAttributedString(string: "\(row) Seconds", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
            }
        default:
            return NSAttributedString(string: "\(row) Seconds", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        }
    }
    
    @objc func addToFavorites() {
        // add device to favorites and refresh UIBarButtonItems
        
        time?.isFavorite = true
        PersistenceService.saveContext()
        loadBarButtons()
    }
    
    @objc func removeFromFavorites() {
        // remove device from favorites and refresh UIBarButtonItems
        
        time?.isFavorite = false
        PersistenceService.saveContext()
        loadBarButtons()
    }
    
    func loadBarButtons() {
        if time?.isFavorite == false {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add to favorites", style: .plain, target: self, action: #selector(addToFavorites))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Remove from favorites", style: .plain, target: self, action: #selector(removeFromFavorites))
        }
    }
}

