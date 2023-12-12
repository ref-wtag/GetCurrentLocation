//
//  LocationSearchViewController.swift
//  GetCurrentLocation
//
//  Created by Refat E Ferdous on 12/12/23.
//

import UIKit

class LocationSearchViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var label :UILabel!
//    = {
//        let label = UILabel()
//        label.text = "Where to"
//        label.font = .systemFont(ofSize: 24, weight: .semibold)
//        return label
//    }()
    
    @IBOutlet var field : UITextField!
//    = {
//        let field = UITextField()
//        field.placeholder = "Enter Destination"
//    
//        field.layer.cornerRadius = 9
//        field.backgroundColor = .tertiarySystemBackground
//        field.leftView = UIView(frame : CGRect(x: 0, y: 0, width : 10, height : 50))
//        field.leftViewMode = .always
//        field.textColor = .black
//        
//        return field
//    }()
    
    @IBOutlet var tableView : UITableView!
//    = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return table
//    }()
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .secondarySystemBackground
        //view.addSubview(label)
       // view.addSubview(field)
        field.delegate = self
        tableView.delegate = self
        //tableView.backgroundColor = .black
        tableView.dataSource = self
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        label.sizeToFit()
//        label.frame = CGRect(x: 10, y: 10, width : label.frame.size.width, height : label.frame.size.height)
//        field.frame = CGRect(x: 10, y: 20+label.frame.size.height, width: view.frame.size.width-20, height: 50)
//        
//        let tableY : CGFloat = field.frame.origin.y+field.frame.size.height+5
//        tableView.frame = CGRect(x: 0, y: tableY, width: view.frame.size.width, height: view.frame.size.height - tableY)
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.resignFirstResponder()
        if let text =  field.text, !text.isEmpty {
            LocationManager.shared.findLocations(with: text) { [weak self] locations in
                
                DispatchQueue.main.async {
                    self?.locations = locations
                    self?.tableView.reloadData()
                }
               
            }
        }
            
            return true
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = locations[indexPath.row].title
        //cell.textLabel?.text = "hello there"
        cell.contentView.backgroundColor = .secondarySystemBackground
        cell.backgroundColor = .secondarySystemBackground
       cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = .black
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let coordinates = locations[indexPath.row].coordinates
        
        
    }

}
