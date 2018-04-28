//
//  HelpViewController.swift
//  WVU Mobile
//
//  Created by Richard Deal on 4/4/15.
//  Copyright (c) 2015 WVUMobile. All rights reserved.
//

import UIKit
import MessageUI

class HelpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate {
    
    var tableView = UITableView()
    
    var phoneNumbers: [[String]] = [["3042847522", "3042932677", "18009880096"],
                                    ["3042925100"],
                                    ["", "18007842433", "18002738255"],
                                    ["3042936997"],
                                    ["3042933792", "3042936924", "3042935590", "18009880096", "3042857200"]]
    
    var nameOfNumbers: [[String]] = [["the Morgantown Police", "the University Police", "WVU Emergency"],
                                     ["the Rape & Domestic Violence Information Center"],
                                     ["", "the National 24/7 Suicide Hotline", "the Military Veterans Suicide Hotline"],
                                     ["the Carruth Center"],
                                     ["Environmental Health", "Health Sciences", "Faculty-Staff Assistance", "the Parents Club", "Student Health"]]
    
    override func viewDidLoad() {
        self.title = "Help"
        
        /*
         Set up table view.
         */
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 49), style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 43.0
        tableView.showsVerticalScrollIndicator = false
        
        self.view.addSubview(self.tableView)
        
        super.viewDidLoad()
    }

    // Call number stored in Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 0 {
            sendMessageButtonTapped(sender: UITableViewCell())
        }
        else {
            alert(number: phoneNumbers[indexPath.section][indexPath.row], name: nameOfNumbers[indexPath.section][indexPath.row])
        }
        
        self.tableView.cellForRow(at: indexPath as IndexPath)?.isSelected = false
    }
    
    // Alert so people don't fat finger it
    func alert(number: String, name: String) {
        let phoneNumber = number
        let nameOfNumber = name
        let alertController = UIAlertController(title: "", message: "Call \(nameOfNumber)?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "Call", style: .default) { (action) in
            if let url = URL(string: "tel://\(phoneNumber)") {
                UIApplication.shared.openURL(url)
            }
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            
        }
    }
    
    // Functionality of Text Message Button
    @IBAction func sendMessageButtonTapped(sender: AnyObject) {
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "START";
        messageVC.recipients = ["741-741"]
        messageVC.messageComposeDelegate = self;
        
        self.present(messageVC, animated: false, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case MessageComposeResult.cancelled:
            self.dismiss(animated: true, completion: nil)
        case .failed:
            self.dismiss(animated: true, completion: nil)
        case .sent:
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    // Return number of rows in section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        else if section == 1 {
            return 1
        }
        else if section == 2 {
            return 3
        }
        else if section == 3 {
            return 1
        }
        else if section == 4 {
            return 5
        }
        else {
            return 0
        }
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "EMERGENCY"
        }
        else if section == 1 {
            return "RAPE & DOMESTIC VIOLENCE"
        }
        else if section == 2 {
            return "SUICIDE PREVENTION"
        }
        else if section == 3 {
            return "COUNSELING & PSYCHOLOGICAL SERVICES"
        }
        else if section == 4 {
            return "OTHER SERVICES"
        }
        else {
            return ""
        }
    }
    
    // Footer
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "Anyone experiencing a life threatening emergency should always call 911."
        }
        else if section == 1 {
            return ""
        }
        else if section == 2 {
            return "If you or someone you know is feeling suicidal, these hotlines can provide assistance."
        }
        else if section == 3 {
            return "Provides a variety of psychological, psychiatric, and counseling services including: individual, couples, educational, and career counseling."
        }
        else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        cell.selectionStyle = .default
        
        if indexPath.row == 0 && indexPath.section == 0 {
            cell.selectionStyle = .default
            cell.textLabel?.text = "Morgantown Police"
            cell.detailTextLabel?.text = "(304) 284-7522"
        }
        else if indexPath.row == 1 && indexPath.section == 0 {
            cell.textLabel?.text = "University Police"
            cell.detailTextLabel?.text = "(304) 293-2677"
        }
        else if indexPath.row == 2 && indexPath.section == 0 {
            cell.textLabel?.text = "WVU Emergency"
            cell.detailTextLabel?.text = "1-800-988-0096"
        }
        else if indexPath.row == 0 && indexPath.section == 1 {
            cell.textLabel?.text = "Information Center"
            cell.detailTextLabel?.text = "(304) 292-5100"
        }
        else if indexPath.row == 0 && indexPath.section == 2 {
            cell.textLabel?.text = "Crisis Text Line"
            cell.detailTextLabel?.text = "741-741"
        }
        else if indexPath.row == 1 && indexPath.section == 2 {
            cell.textLabel?.text = "24/7 Hotline"
            cell.detailTextLabel?.text = "1-800-784-2433"
        }
        else if indexPath.row == 2 && indexPath.section == 2 {
            cell.textLabel?.text = "Veterans Hotline"
            cell.detailTextLabel?.text = "1-800-273-TALK"
        }
        else if indexPath.row == 0 && indexPath.section == 3 {
            cell.textLabel?.text = "Carruth Center"
            cell.detailTextLabel?.text = "(304) 293-6997"
        }
        else if indexPath.row == 0 && indexPath.section == 4 {
            cell.textLabel?.text = "Environmental Health"
            cell.detailTextLabel?.text = "(304) 293-3792"
        }
        else if indexPath.row == 1 && indexPath.section == 4 {
            cell.textLabel?.text = "Health Sciences"
            cell.detailTextLabel?.text = "(304) 293-6924"
        }
        else if indexPath.row == 2 && indexPath.section == 4 {
            cell.textLabel?.text = "Faculty-Staff Assist."
            cell.detailTextLabel?.text = "(304) 293-5590"
        }
        else if indexPath.row == 3 && indexPath.section == 4 {
            cell.textLabel?.text = "Parents Club"
            cell.detailTextLabel?.text = "1-800-WVU-0096"
        }
        else if indexPath.row == 4 && indexPath.section == 4 {
            cell.textLabel?.text = "Student Health"
            cell.detailTextLabel?.text = "(304) 285-7200"
        }
        return cell
    }

    // Pregenerated.
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.restorationIdentifier = "HelpViewController"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
