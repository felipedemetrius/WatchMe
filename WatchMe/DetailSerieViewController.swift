//
//  DetailSerieViewController.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/20/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit

class DetailSerieViewController: UIViewController {

    enum CellIndex: Int {
        
        case Image = 0
        case Actions = 1
        case NextEpisode = 2
        case MoreEpisodes = 3
        case Overview = 4
        
        var description : Int { return rawValue }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var serie : SerieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = serie.title
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
    }

    private func configureTableView(){
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 175
        
        tableView.register(UINib(nibName: "ActionsSerieTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionsSerieTableViewCell")
        
        tableView.register(UINib(nibName: "ImageDetailSerieTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageDetailSerieTableViewCell")
        
        tableView.register(UINib(nibName: "NextEpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "NextEpisodeTableViewCell")

        tableView.register(UINib(nibName: "MoreEpisodesTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreEpisodesTableViewCell")

        tableView.register(UINib(nibName: "OverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "OverviewTableViewCell")

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

extension DetailSerieViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if indexPath.row == CellIndex.Address.description {
//            goToAddress()
//        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case CellIndex.Image.description:   return getImageCell(tableView: tableView, indexPath: indexPath)
        case CellIndex.Actions.description: return getActionsCell(tableView: tableView, indexPath: indexPath)
        case CellIndex.NextEpisode.description: return getNextEpisodeCell(tableView: tableView, indexPath: indexPath)
        case CellIndex.MoreEpisodes.description: return getMoreEpisodesCell(tableView: tableView, indexPath: indexPath)
        case CellIndex.Overview.description: return getOverviewCell(tableView: tableView, indexPath: indexPath)

        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 { return 140 }
        if indexPath.row == 2 { return 175 }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }

}

extension DetailSerieViewController {
    
    func getImageCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDetailSerieTableViewCell", for: indexPath) as? ImageDetailSerieTableViewCell
                
        cell?.configureImage(imdb: serie.imdb)
        
        
        return cell!
    }
    
    func getActionsCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionsSerieTableViewCell", for: indexPath) as? ActionsSerieTableViewCell
        
        
        return cell!
    }
    
    func getNextEpisodeCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NextEpisodeTableViewCell", for: indexPath) as? NextEpisodeTableViewCell
        
        
        return cell!
    }
    
    func getMoreEpisodesCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreEpisodesTableViewCell", for: indexPath) as? MoreEpisodesTableViewCell
        
        
        return cell!
    }
    
    func getOverviewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OverviewTableViewCell
        
        
        return cell!
    }
    
}


