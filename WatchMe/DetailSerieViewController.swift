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
    var nextEpisode : EpisodeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = serie.title
        configureTableView()
        configureNextEpisode()
        getLocalSerie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func getLocalSerie(){
        if let serieLocal = SerieRepository.getLocal(slug: serie.slug ?? "") {
            serie = serieLocal
            tableView.reloadData()
        }
    }
    
    private func configureNextEpisode(){
        
        EpisodeRepository.getNextEpisode(slug: serie.slug ?? "") { [weak self] result in
            self?.nextEpisode = result
            self?.tableView.reloadData()
        }
    }

    private func configureTableView(){
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 175
        
        tableView.register(UINib(nibName: "ActionsSerieTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionsSerieTableViewCell")
        
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        
        tableView.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeTableViewCell")

        tableView.register(UINib(nibName: "MoreEpisodesTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreEpisodesTableViewCell")

        tableView.register(UINib(nibName: "OverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "OverviewTableViewCell")

    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSeasons" {
            let vc = segue.destination as? SeasonsSerieViewController
            if let serie = sender as? SerieModel {
                vc?.serie = serie
            }
        } else if segue.identifier == "goToDetailEpisode" {
            let vc = segue.destination as? DetailEpisodeViewController
            if let episode = sender as? EpisodeModel {
                vc?.serie = serie
                vc?.episode = episode
            }
        }
    }
 

}

extension DetailSerieViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == CellIndex.MoreEpisodes.description {
            performSegue(withIdentifier: "goToSeasons", sender: serie)
        }
        
        if indexPath.row == CellIndex.NextEpisode.description {
            if let episode = nextEpisode {
                performSegue(withIdentifier: "goToDetailEpisode", sender: episode)
            }
        }
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
        
        if indexPath.row == 0 { return 139 }
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as? ImageTableViewCell
                
        cell?.configureImage(imdb: serie.imdb)
        
        return cell!
    }
    
    func getActionsCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionsSerieTableViewCell", for: indexPath) as? ActionsSerieTableViewCell
        
        cell?.configureCell(serie: serie)
        
        return cell!
    }
    
    func getNextEpisodeCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as? EpisodeTableViewCell
        
        cell?.configureNextEpisode(episode: nextEpisode)
        
        return cell!
    }
    
    func getMoreEpisodesCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreEpisodesTableViewCell", for: indexPath) as? MoreEpisodesTableViewCell
        return cell!
    }
    
    func getOverviewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OverviewTableViewCell
        
        cell?.label.text = serie.overview
        
        return cell!
    }
    
}


