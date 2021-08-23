//
//  ListHelper.swift
//  test1
//
//  Created by 장진혁 on 2021/08/22.
//

import UIKit
import SwiftSoup

class ListHelper: NSObject {
  static let shared = ListHelper()
  
  private var callback: (() -> ())?
  private var document: Document = Document("")
  
  var imageList: Array<String> = Array()
  var isZoom: Bool = false
  
  var cachingDictionary: Dictionary<String,Data> = Dictionary()
  
  func getParsingData(callback: @escaping () -> Void) {
    
    self.callback = callback
    
    let url = "https://www.google.com/search?q=%EC%A7%91%EB%8B%A5&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjo95XbncTyAhU9xosBHXrPD0wQ_AUoAnoECAEQBA&biw=1920&bih=944"
    
    downloadHTML(url)
  }
  
  func downloadHTML(_ urlString: String) {
    
    guard let url = URL(string: urlString) else {
      DispatchQueue.main.async {
        UIAlertController.showAlert("Error: \(urlString) doesn't seem to be a valid URL", (UIApplication.shared.windows.first?.rootViewController)!)
      }
      self.callback!()
      return
    }
    
    do {
      
      let html = try NSString(contentsOf: url, encoding: String.Encoding.isoLatin1.rawValue)
      document = try SwiftSoup.parse(html as String)
      parse()
    } catch let error {

      self.callback!()
      DispatchQueue.main.async {
        UIAlertController.showAlert("Error: \(error)", (UIApplication.shared.windows.first?.rootViewController)!)
      }
    }
    
  }
  
  func parse() {
    do {
      let elements: Elements = try document.select("img[src]")
      //transform it into a local object (Item)
      for element in elements {
        let text = try element.attr("src")
        if text.contains("https://") {
          imageList.append(text)
        }
      }
      
      self.callback!()
    } catch let error {
      self.callback!()
      
      DispatchQueue.main.async {
        UIAlertController.showAlert("Error: \(error)", (UIApplication.shared.windows.first?.rootViewController)!)
      }
      
    }
  }
}
