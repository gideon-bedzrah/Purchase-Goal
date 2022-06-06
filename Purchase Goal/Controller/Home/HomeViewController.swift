//
//  HomeViewController.swift
//  Purchase Goal
//
//  Created by Gideon Bedzrah on 15/10/2020.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var announcementCollection: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var dealsCollection: UICollectionView!
    var productData = ProductData.data
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        announcementCollection.dataSource = self
        announcementCollection.delegate = self
        
        dealsCollection.dataSource = self
        dealsCollection.delegate = self
        
        pageControl.currentPageIndicatorTintColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1)
        
        
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search for products"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true;
        
        
        
    }

    
    @IBAction func browseButtonTapped(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "toMoreDeals", sender: self)
        
    }
    

}

extension HomeViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // do nothing
    }
    
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count: Int?
        
        if collectionView == self.announcementCollection {
            count = 3
            pageControl.numberOfPages = count!
        }else if collectionView == self.dealsCollection {
            count = productData.count
        }
        return count!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell?
        
        if collectionView == self.announcementCollection {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnouncementCell", for: indexPath)
           
            
        }else if collectionView == self.dealsCollection {
            
          let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "DealsCell", for: indexPath) as! DealsCollectionCell
            cell2.setProductDetails = productData[indexPath.row]
            
            return cell2
        }
      
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(
                (announcementCollection.contentOffset.x / announcementCollection.frame.width)
                .rounded(.toNearestOrAwayFromZero)
            )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size: CGSize?
        
        if collectionView == self.announcementCollection {
            size = CGSize(width: announcementCollection.frame.width, height: announcementCollection.frame.height)
        } else if collectionView == self.dealsCollection {
            let bounds = dealsCollection.bounds

            size = CGSize(width: bounds.width / 2 - 30, height: (bounds.width / 2 - 30) + 50)
        }
        
       return size!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        var edge: UIEdgeInsets?
        
        if collectionView == self.announcementCollection {
            
            edge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        } else if collectionView == self.dealsCollection {
            
            
            edge = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
            
        }
        
        return edge!
        
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.announcementCollection {
            print("coming soon")
        }else {
            
            self.performSegue(withIdentifier: "toProductDetail", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)
        
        if segue.identifier == "toProductDetail" {
            let PDVC = segue.destination as! ProductDetailViewController
            let indexPath = dealsCollection.indexPathsForSelectedItems
            PDVC.seletedCell = productData[(indexPath?[0].row)!]
        } else if segue.identifier == "toMoreDeals" {
            let dealsvc = segue.destination as! DealsViewController
            dealsvc.passedData = productData
        }
        
        
    }
}
