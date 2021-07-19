//
//  ViewController.swift
//  Carousel
//
//  Created by Артем Иревлин on 25.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var interest = Service.fetchInterest()
    
    var numberOfItems: Int = 4
    
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        
        loadMoreData()
        
        //TO-DO Razbor
        let floawLayout = UPCarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: collectionView.frame.size.height)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0.8
        floawLayout.sideItemAlpha = 1.0
        floawLayout.spacingMode = .fixed(spacing: 5.0)
        collectionView.collectionViewLayout = floawLayout
        //-------------
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    //----------------------------
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    fileprivate var currentPage: Int = 0 {
        didSet {
            //            print("page at centre = \(currentPage)")
        }
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    //--------
    
    override func viewDidAppear(_ animated: Bool) {
        let indexPath = IndexPath(item: numberOfItems / 2, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    
    func registerCell() {
        let customCellNib = UINib(nibName: "CustomCell", bundle: .main)
        collectionView.register(customCellNib, forCellWithReuseIdentifier: "CustomCell")
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interest.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"CustomCell", for: indexPath) as? CustomCell else {
            return UICollectionViewCell()
        }
        let interests = interest[indexPath.item % interest.count]
        cell.interest = interests
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.x
        if position > (collectionView.contentSize.width+2-scrollView.frame.size.width) {
            scrollView.contentOffset = CGPoint.zero
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {
                // Fake background loading task for 2 seconds
                sleep(2)
                // Download more data here
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
}


