//
//  paymentDetailViewController.swift
//  Purchase Goal
//
//  Created by Gideon Bedzrah on 14/10/2020.
//

import UIKit

class PaymentDetailViewController: UIViewController {

    @IBOutlet weak var progressOne: UILabel!
    @IBOutlet weak var progressGoal: UILabel!
    @IBOutlet weak var lineOne: UIView!
    
    @IBOutlet weak var progressTwo: UILabel!
    @IBOutlet weak var progressComplete: UILabel!
    @IBOutlet weak var lineTwo: UIView!
    
    @IBOutlet weak var progressThree: UILabel!
    @IBOutlet weak var progressDelivery: UILabel!
    
    @IBOutlet weak var weeklyGraphCollection: UICollectionView!
    
    @IBOutlet weak var dailyTableView: UITableView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // delegates and data sources
        
        weeklyGraphCollection.dataSource = self
        weeklyGraphCollection.delegate = self
        SwitchProgress(2)
        
        dailyTableView.dataSource = self
        
        // page control
        pageControl.currentPageIndicatorTintColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1)
        
        pageControl.tintColor = UIColor.systemGray3
        
        
        
        
    }

    func SwitchProgress(_ stage: Int) {
        
        progressOne.layer.cornerRadius = progressOne.frame.height / 2
        
        progressTwo.layer.cornerRadius = progressOne.frame.height / 2
        
        progressThree.layer.cornerRadius = progressOne.frame.height / 2
        switch stage {
        
        case 1:
            progressOne.backgroundColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1)
            progressGoal.textColor = .label
            
        case 2:
            progressOne.backgroundColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1)
            progressGoal.textColor = .label
            
            progressTwo.backgroundColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1)
            progressComplete.textColor = .label
            
            lineOne.backgroundColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1)
            
        case 3:
            progressOne.backgroundColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1)
            progressGoal.textColor = .label
            
            progressTwo.backgroundColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1)
            progressComplete.textColor = .label
            
            progressThree.backgroundColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1)
            progressDelivery.textColor = .label
            
            lineOne.backgroundColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1)
            lineTwo.backgroundColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1)
        default:
            progressOne.backgroundColor = .systemGray3
            progressGoal.textColor = .systemGray3
            
            progressTwo.backgroundColor = .systemGray3
            progressComplete.textColor = .systemGray3
            
            progressThree.backgroundColor = .systemGray3
            progressDelivery.textColor = .systemGray3
        }
     
    }
    
}


extension PaymentDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let k = 5
        pageControl.numberOfPages = k
        return k
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weeklyGraph", for: indexPath)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(
                (weeklyGraphCollection.contentOffset.x / weeklyGraphCollection.frame.width)
                .rounded(.toNearestOrAwayFromZero)
            )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: weeklyGraphCollection.frame.width, height: weeklyGraphCollection.frame.height)
    }
    
    
}

extension PaymentDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Daily Financing"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyGraph", for: indexPath)
        return cell
    }
    
    
}
