//
//  SeasonsSerieViewController.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/21/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit

class SeasonsSerieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var serie : SerieModel!
    
    var seasons : [SeasonModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureDatasource()
    }
    
    private func configureDatasource(){
        
        SeasonRepository.getSeasons(slug: serie.slug ?? "") { [weak self] seasons in
            
            if let seasons = seasons {
                self?.seasons = seasons
                self?.tableView.reloadData()
            }
            
        }
    }
    
    private func configureTableView(){
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 175
        
        tableView.register(UINib(nibName: "NextEpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "NextEpisodeTableViewCell")
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

extension SeasonsSerieViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let seasons = self.seasons else {return 0}
        let season = seasons[section]
        return season.episodes?.count ??  0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let seasons = self.seasons else {return 0}
        return seasons.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let seasons = self.seasons else {return UITableViewCell()}

        let season  = seasons[indexPath.section]
        
        guard let episode = season.episodes?[indexPath.row] else {return UITableViewCell()}
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NextEpisodeTableViewCell", for: indexPath) as? NextEpisodeTableViewCell
        
        cell?.configureEpisode(episode: episode, serie: serie)
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let seasons = self.seasons else {return nil}

        let headerView = Bundle.main.loadNibNamed("HeaderSeasonTableViewCell", owner: nil, options: nil)! [0] as! HeaderSeasonTableViewCell
        
        let season  = seasons[section]
        headerView.lblNumber.text = season.number?.description
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 175
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }

    
}


