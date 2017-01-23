//
//  SearchViewController.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/20/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource : [SerieModel] = []
    var textSearch : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search Series"
        searchBar.text = textSearch

        configureDataSource(query: searchBar.text ?? "")
        configureCollectionView()
    }
    
    fileprivate func configureDataSource(query: String){
        
        SerieRepository.searchSeries(text: query, completionHandler: {[weak self] series in
            
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
        
        layout.itemSize = CGSize(width: screenWidth / 2 - 10, height: screenWidth / 2 + screenWidth/5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: "SerieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SerieCollectionViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDetailSerie" {
            let vc = segue.destination as? DetailSerieViewController
            if let serie = sender as? SerieModel {
                vc?.serie = serie
            }
        }
    }
 

}

extension SearchViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        configureDataSource(query: searchBar.text ?? "")
        textSearch = searchBar.text ?? ""
    }
    
}

extension SearchViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        searchBar.endEditing(true)
        
        let maximumOffset = scrollView.contentSize.height - self.collectionView.frame.size.height
        
        if dataSource.count == 0 {
            return
        }
        
        if  maximumOffset - scrollView.contentOffset.y <= 0  {
            
            SerieRepository.nextSearch(text: textSearch, completionHandler: {[weak self] series in
                
                if let seriess = series, seriess.count > 0 {
                    self?.dataSource += seriess
                    self?.collectionView.reloadData()
                }
                
            })
        }
        
    }

}


extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToDetailSerie", sender: dataSource[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        
        return CGSize(width: screenWidth/2 - 10, height: screenWidth/2 + screenWidth/5)
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


