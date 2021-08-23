//
//  CollectionViewController.swift
//  test1
//
//  Created by 장진혁 on 2021/08/22.
//

import UIKit

class CollectionViewController: UIViewController {
  
  var collectionView: UICollectionView!
  
  var imageList = ListHelper.shared.imageList
  
  var index: Int!
  var isMove: Bool = false
  
  init(_ value: Int) {
    self.index = value
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let flowlayout = UICollectionViewFlowLayout()
    flowlayout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    flowlayout.minimumInteritemSpacing = 0
    flowlayout.minimumLineSpacing = 0
    flowlayout.scrollDirection = .horizontal
  
    
    collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowlayout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.reusableIdentifier)
    
    collectionView.backgroundColor = .systemBackground
    collectionView.isPagingEnabled = true
    collectionView.showsHorizontalScrollIndicator = false

    setUpCollectionView()
  }
  
  func setUpCollectionView() {
    
    view.addSubview(collectionView)
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    
  }
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    imageList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.reusableIdentifier, for: indexPath) as! DetailCollectionViewCell
    cell.configuration(data: imageList[indexPath.row])
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
  
  override func viewDidLayoutSubviews() {
    
    if !isMove {
      DispatchQueue.main.async {
        self.collectionView.isPagingEnabled = false
        self.collectionView.scrollToItem(at:IndexPath(item: self.index, section: 0), at: .centeredHorizontally, animated: false)
        self.collectionView.isPagingEnabled = true
        
        self.isMove = true
      }
    }
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
}
