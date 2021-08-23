//
//  DetailCollectionViewCell.swift
//  test1
//
//  Created by 장진혁 on 2021/08/22.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate, UIGestureRecognizerDelegate {

  private var detailImageView: UIImageView = {
    var imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  private var scrollView: UIScrollView = UIScrollView()

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpUI() {
    
    scrollView.delegate = self
    scrollView.minimumZoomScale = 1.0
    scrollView.maximumZoomScale = 6.0
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.showsVerticalScrollIndicator = false
    
    let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap(_:)))
    doubleTap.delegate = self
    doubleTap.numberOfTapsRequired = 2
    scrollView.addGestureRecognizer(doubleTap)
    
    scrollView.frame = contentView.frame
    contentView.addSubview(scrollView)
    
    detailImageView.frame = scrollView.frame
    scrollView.addSubview(detailImageView)
  }
  
  func configuration(data:String) {
    
    if let cacheData =  ListHelper.shared.cachingDictionary[data] {
      detailImageView.image = UIImage(data: cacheData)
    } else {
      let userDefault: UserDefaults = UserDefaults()
      
      if let saveImageData = userDefault.data(forKey: data) {
        detailImageView.image = UIImage(data: saveImageData)
        ListHelper.shared.cachingDictionary.updateValue(saveImageData, forKey: data)
      } else {
        let url = URL(string: data)
        let imageData = try! Data(contentsOf: url!)
        
        userDefault.set(imageData, forKey: data)
        ListHelper.shared.cachingDictionary.updateValue(imageData, forKey: data)
        detailImageView.image = UIImage(data: imageData)
      }
    }
  }
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    
    return detailImageView
  }
  
  @objc func doubleTap(_ gesture: UITapGestureRecognizer) {
    
    if scrollView.zoomScale == 1.0 {
      scrollView.maximumZoomScale = 3
      scrollView.zoom(to: CGRect(x: gesture.location(in: scrollView).x,
                                 y: gesture.location(in: scrollView).y,
                                 width: 0,
                                 height: 0),
                      animated: true)
      scrollView.maximumZoomScale = 6
    } else {
      scrollView.setZoomScale(1.0, animated: true)
    }
  }
  
  
}
