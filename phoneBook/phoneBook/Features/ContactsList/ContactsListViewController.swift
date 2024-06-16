//
//  ContactsListViewController.swift
//  phoneBook
//
//  Created by Jaehwi Kim on 2024/01/10.
//

import UIKit
import Contacts

class ContactsListViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var contactsTableView: UITableView!
    var contactsList: [CNContact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContactsList()
        setTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = dequeueCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell.textLabel?.text = "\(contactsList[indexPath.row].givenName) \(contactsList[indexPath.row].middleName) \(contactsList[indexPath.row].familyName)"
        print("\(cell.textLabel?.text)")
        return cell
    }
    
    func setTableView() {
        self.contactsTableView.backgroundColor = .white
        self.contactsTableView.dataSource = self
    }
    
    func getContactsList() {
        // Contacts DB 접근 object 생성
        DispatchQueue.global().async {
            let store = CNContactStore()
            store.requestAccess(for: .contacts) { (isAllowed, error) in
                guard isAllowed else {
                    return;
                }
                
                let request: CNContactFetchRequest = CNContactFetchRequest(keysToFetch: [
                    CNContactGivenNameKey,
                    CNContactMiddleNameKey,
                    CNContactFamilyNameKey,
                    CNContactPhoneNumbersKey,
                    CNContactOrganizationNameKey,
                ] as [CNKeyDescriptor])
                
                try! store.enumerateContacts(with: request, usingBlock: { contact, _ in
                    if contact.phoneNumbers.isEmpty {
                        return
                    }
                    self.contactsList.append(contact)
                })
            }
            
//            self.contactsList.forEach { element in
//                print("\(element.givenName) \(element.middleName) \(element.familyName)")
//            }
        }
        
    }
}
