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
    
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Trending"
        
        
        configureDataSource()
        configureCollectionView()
        configureSearchBarController()
    }

    private func configureDataSource(){

        SerieRepository.getSeriesTrending(completionHandler: {[weak self] series in
            
            if let series = series {
                self?.dataSource = series
                self?.collectionView.reloadData()
            }
            
        })
    }
    
    private func configureSearchBarController(){
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
        //searchController.searchBar.tintColor = UIColor.whiteColor
        //searchController.searchBar.barTintColor = ColorConstants.orange
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
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSearch" {
            let vc = segue.destination as? SearchViewController
            if let text = sender as? String {
                vc?.textSearch = text
            }
        } else if segue.identifier == "goToDetailSerie" {
            let vc = segue.destination as? DetailSerieViewController
            if let serie = sender as? SerieModel {
                vc?.serie = serie
            }
        }
        
    }
 

}

extension DiscoverViewController: UISearchBarDelegate{
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        searchController.searchBar.placeholder = "Search Series"
        present(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "goToSearch", sender: searchController.searchBar.text)
        searchController.searchBar.text = ""
    }
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
        
        performSegue(withIdentifier: "goToDetailSerie", sender: dataSource[indexPath.row])
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

