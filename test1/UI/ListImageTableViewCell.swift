//
//  ListImageTableViewCell.swift
//  test1
//
//  Created by 장진혁 on 2021/08/22.
//

import UIKit

class ListImageTableViewCell: UITableViewCell {
  
  private var listImageView: UIImageView = {
    var imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    return imageView
  }()
  
  private var listTextLabel: UILabel = {
    var label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.lineBreakMode = .byCharWrapping
    label.numberOfLines = 0
    
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  private func setUpUI() {

    contentView.addSubview(listImageView)
    listImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
    listImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
    listImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
    listImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
    
    contentView.addSubview(listTextLabel)
    listTextLabel.topAnchor.constraint(equalTo: listImageView.topAnchor).isActive = true
    listTextLabel.leadingAnchor.constraint(equalTo: listImageView.trailingAnchor, constant: 4).isActive = true
    listTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
    listTextLabel.bottomAnchor.constraint(equalTo: listImageView.bottomAnchor).isActive = true
    
  }
  
  func configuration(data:String) {
    
    let userDefault: UserDefaults = UserDefaults()
    
    if let cacheData =  ListHelper.shared.cachingDictionary[data] {
      listImageView.image = UIImage(data: cacheData)
    } else {
      if let saveImageData = userDefault.data(forKey: data) {
        listImageView.image = UIImage(data: saveImageData)
        ListHelper.shared.cachingDictionary.updateValue(saveImageData, forKey: data)
      } else {
        let url = URL(string: data)
        let imageData = try! Data(contentsOf: url!)
        
        userDefault.set(imageData, forKey: data)
        ListHelper.shared.cachingDictionary.updateValue(imageData, forKey: data)
        listImageView.image = UIImage(data: imageData)
      }
    }
    
    listTextLabel.text = data
  }
}
