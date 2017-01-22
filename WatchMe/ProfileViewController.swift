//
//  ProfileViewController.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/22/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var dataSource : [SerieModel]? {
        return seriesWatching
    }
    
    private var seriesWatching : [SerieModel]?
    private var seriesNextUp : [SerieModel]?
    
    fileprivate var segueSerie : SerieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureDatasource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureDatasource()
        tableView.reloadData()
    }
    
    private func configureDatasource(){
        
        seriesWatching = SerieRepository.getSeriesWithEpisodes()
        
        guard seriesWatching != nil else {return}
        
        for (index, serie) in seriesWatching!.enumerated(){
            
            EpisodeRepository.getNextEpisode(slug: serie.slug ?? "") { [weak self] episode in
                self?.seriesWatching![index].nextEpisode = episode
                self?.tableView.reloadData()
            }
        }
        
        tableView.reloadData()
    }
    
    private func configureTableView(){
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 175
        
        tableView.register(UINib(nibName: "NextEpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "NextEpisodeTableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func changeSegmentControl(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailEpisode" {
            let vc = segue.destination as? DetailEpisodeViewController
            if let episode = sender as? EpisodeModel {
                vc?.serie = segueSerie
                vc?.episode = episode
            } else {
                return
            }
        }
    }

}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let series = self.dataSource else {return 0}
        let serie = series[section]
        
        if segmentControl.selectedSegmentIndex == 0 {
            return serie.watchedEpisodes.count
        } else {
            return serie.nextEpisode != nil ? 1 : 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let series = self.dataSource else {return}
        
        let serie = series[indexPath.section]
        
        var episode : EpisodeModel?
        
        if segmentControl.selectedSegmentIndex == 0 {
            episode = serie.watchedEpisodes[indexPath.row]
        } else {
            episode = serie.nextEpisode
        }
        
        self.segueSerie = serie
        performSegue(withIdentifier: "goToDetailEpisode", sender: episode)        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let series = self.dataSource else {return 0}
        return series.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let series = self.dataSource else {return UITableViewCell()}
        
        let serie  = series[indexPath.section]
        
        var episode : EpisodeModel?
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NextEpisodeTableViewCell", for: indexPath) as? NextEpisodeTableViewCell
        
        if segmentControl.selectedSegmentIndex == 0 {
            episode = serie.watchedEpisodes[indexPath.row]
            cell?.configureEpisode(episode: episode!, serie: serie)
        } else {
            episode = serie.nextEpisode
            cell?.configureNextEpisode(episode: episode)
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let series = self.dataSource else {return nil}
        
        let headerView = Bundle.main.loadNibNamed("HeaderSeasonTableViewCell", owner: nil, options: nil)! [0] as! HeaderSeasonTableViewCell
        
        let serie  = series[section]
        headerView.lblNumber.text = serie.title
        
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
