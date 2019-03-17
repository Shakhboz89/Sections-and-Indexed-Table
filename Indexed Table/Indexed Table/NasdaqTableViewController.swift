//
//  NasdaqTableViewController.swift
//  Indexed Table
//
//  Created by MacBook on 3/17/19.
//  Copyright © 2019 Shakhboz. All rights reserved.
//

import UIKit

class NasdaqTableViewController: UITableViewController {
    
    let companies = ["Comcast Corp", "Microsoft", "Intel", "Cisco Systems", "Apple", "Ebay", "Marvell", "Nvidia Corp", "Starbucks Corp", "Adobe Inc", "Netflix Inc", "Amazon", "Symantec Corp", "Huntington Bancshares Inc", "Qualcomm Inc", "Activision Blizzard", "Pan American Silver", "Mannkind Corp", "Gulfport Energy Corp", "Bed Bath & Beyound", "Amgen Inc", "Amarin", "Nuance Communications", "Netapp Inc", "Lam Research Corp", "Jetblue Airways Corp", "Peoples Bank", "Maxim Integrated Products", "Amicus Therapeutics Inc", "Fiserv", "Liberty Global", "Novavax", "Sirius XM Holdings Inc", "Applied Materials Inc", "Bioscrip Inc", "Plug Power", "Maiden Holdings Ltd", "Gilead Sciences", "Immunogen", "Celgene", "FTB", "Mylan NV", "Flex Ltd"]
    
    let companyIndexTitles = ["A", "B", "C", "D", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var companyDict = [String: [String]]()
    var companySectionTitles = [String]()
    
    func creatCompanyDict() {
        for company in companies {
            // Get the first letter of the company name and build the dictionary
            let firstLetterIndex = company.index(company.startIndex, offsetBy: 1)
            let companyKey = String(company[..<firstLetterIndex])
            
            if var companyValues = companyDict[companyKey] {
                companyValues.append(company)
                companyDict[companyKey] = companyValues
            } else {
                companyDict[companyKey] = [company]
            }
        }
        
        // Get the section titles from the dictionary's key and sort them in ascending order
        companySectionTitles = [String](companyDict.keys)
        companySectionTitles = companySectionTitles.sorted(by: { $0 < $1 })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Generate the company dictionary
        creatCompanyDict()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return companySectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of row in the section.
        let companyKey = companySectionTitles[section]
        guard let companyValues = companyDict[companyKey] else {
            return 0
        }
        return companyValues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        let companyKey = companySectionTitles[indexPath.section]
        if let companyValues = companyDict[companyKey] {
            cell.textLabel?.text = companyValues[indexPath.row]
            
            // Convert the company name to lower case and then replace all occurences of a space with an underscore
            let imageFileName = companyValues[indexPath.row].lowercased().replacingOccurrences(of: " ", with: "_")
            cell.imageView?.image = UIImage(named: imageFileName)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return companySectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return companyIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = companySectionTitles.index(of: title) else {
            return -1
        }
        
        return index
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.backgroundView?.backgroundColor = UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        headerView.textLabel?.textColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
    }


}
