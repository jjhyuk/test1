//
//  ViewController.swift
//  test1
//
//  Created by 장진혁 on 2021/08/22.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {
  
  var imageList: Array<String> = Array()
  
  var tableView: UITableView = {
    var tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(ListImageTableViewCell.self, forCellReuseIdentifier: ListImageTableViewCell.reusableIdentifier)
    
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setUpTableView()
    
    DispatchQueue.global().async {
      ListHelper.shared.getParsingData {
        DispatchQueue.main.async {
          self.imageList = ListHelper.shared.imageList
          self.tableView.reloadData()
        }
      }
    }
  }
  
  func setUpTableView() {
    
    view.addSubview(tableView)
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return imageList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ListImageTableViewCell.reusableIdentifier) as! ListImageTableViewCell
    cell.configuration(data: imageList[indexPath.row])
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    
    self.navigationController?.pushViewController(CollectionViewController(indexPath.row), animated: true)
  }
}

extension UIAlertController {
  static public func showAlert(_ message: String, _ controller: UIViewController) {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    controller.present(alert, animated: true, completion: nil)
  }
}

