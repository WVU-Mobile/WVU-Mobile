//
//  SettingsTableViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 1/31/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    var titles = ["",
                  "Developers",
                  "WVU Mobile",
                  "Send Feedback"]
    
    var footers = ["You can toggle Night Mode from any view by triple tapping the Navigation Bar.",
                   "If you would like to see more from us, please follow us on Twitter!",
                   "You can also like and follow WVU Mobile on Facebook and Twitter!",
                   "Please send questions, suggestions, or bug reports to our email address."]

    var favorite:DiningHall = .Boreman

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 1
        } else {
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "nightMode", for: indexPath)
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "favoriteDining", for: indexPath)
            }
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "social", for: indexPath)
            if indexPath.row == 0 {
                cell.textLabel?.text = "Kate"
                cell.detailTextLabel?.text = "@kaitinthecosmos"
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "Ricky"
                cell.detailTextLabel?.text = "@rickydeal11"
            }
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "social", for: indexPath)
            if indexPath.row == 0 {
                cell.textLabel?.text = "Follow on Twitter"
                cell.detailTextLabel?.text = "@wvumobile"
            } else {
                cell.textLabel?.text = "Like on Facebook"
                cell.detailTextLabel?.text = ""
            }
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "email", for: indexPath)
            cell.textLabel?.text = "wvumobileapp@gmail.com"
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "nightMode", for: indexPath)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return footers[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
            }
        } else if indexPath.section == 1 {
            let twitter = ["kaitinthecosmos", "rickydeal11"]
            
            if UIApplication.shared.canOpenURL(URL(string: "twitter://user?screen_name=\(twitter[indexPath.row])")!) {
                UIApplication.shared.openURL(URL(string: "twitter://user?screen_name=\(twitter[indexPath.row])")!)
            } else {
                UIApplication.shared.openURL(URL(string: "https://twitter.com/\(twitter[indexPath.row])")!)
            }
        } else if indexPath.section == 2 {
            let socialDeepLink = ["twitter://user?screen_name=WVUMobile", "fb://profile/1532449943665741"]
            let socialURL = ["https://twitter.com/wvumobile", "https://facebook.com/wvumobile"]

            if UIApplication.shared.canOpenURL(URL(string: socialDeepLink[indexPath.row])!) {
                UIApplication.shared.openURL(URL(string: socialDeepLink[indexPath.row])!)
            } else {
                UIApplication.shared.openURL(URL(string: socialURL[indexPath.row])!)
            }
        } else {
            sendEmailButtonTapped()
        }
        self.tableView.cellForRow(at: indexPath)?.isSelected = false
    }

    func sendEmailButtonTapped() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["wvumobileapp@gmail.com"])
        mailComposerVC.setSubject("Feedback - iOS")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
