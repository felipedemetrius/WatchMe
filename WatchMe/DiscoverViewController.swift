//
//  DiscoverViewController.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/19/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource : [SerieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Popular"
        
        configureDataSource()
        configureCollectionView()
    }

    private func configureDataSource(){

        SerieRepository.getSeriesPopular(completionHandler: {[weak self] series in
            
            if let series = series {
                self?.dataSource = series
                self?.collectionView.reloadData()
            }
            
        })
    }

    
    private func configureCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        let screenWidth = UIScreen.main.bounds.width
        
        layout.itemSize = CGSize(width: screenWidth / 2 - 10, height: screenWidth / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: "SerieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SerieCollectionViewCell")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DiscoverViewController : UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let maximumOffset = scrollView.contentSize.height - self.collectionView.frame.size.height
        
        if dataSource.count == 0 {
            return
        }
        
        if  maximumOffset - scrollView.contentOffset.y <= 0  {
            
            SerieRepository.nextSeries(completionHandler: {[weak self] series in
                
                if let seriess = series, seriess.count > 0 {
                    self?.dataSource += seriess
                    self?.collectionView.reloadData()
                }
                
            })
        }

    }
}

extension DiscoverViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        
        return CGSize(width: screenWidth/2 - 10, height: screenWidth/2);
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let serie = dataSource[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SerieCollectionViewCell", for: indexPath) as? SerieCollectionViewCell

        cell?.configureCell(serie: serie)
        
        return cell!
    }
    
}

