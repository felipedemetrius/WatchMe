//
//  DetailEpisodeViewController.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/22/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit

class DetailEpisodeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var serie : SerieModel!
    var episode : EpisodeModel!
    
    enum CellIndex: Int {
        
        case Image = 0
        case Action = 1
        case Infos = 2
        case Overview = 3
        
        var description : Int { return rawValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = serie.title
        configureTableView()
        configureEpisode()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configureEpisode(){
        
        EpisodeRepository.getEpisodeDetail(slug: serie.slug ?? "", season: episode.season, episode: episode.number) { [weak self] episode in
            
            if let episode = episode {
                self?.episode = episode
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
        
        tableView.register(UINib(nibName: "ImageDetailSerieTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageDetailSerieTableViewCell")
        
        tableView.register(UINib(nibName: "OverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "OverviewTableViewCell")
       
        tableView.register(UINib(nibName: "ActionEpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionEpisodeTableViewCell")
        
        tableView.register(UINib(nibName: "InfosEpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "InfosEpisodeTableViewCell")
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

extension DetailEpisodeViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case CellIndex.Image.description:   return getImageCell(tableView: tableView, indexPath: indexPath)
        case CellIndex.Action.description: return getActionCell(tableView: tableView, indexPath: indexPath)
        case CellIndex.Infos.description: return getInfosCell(tableView: tableView, indexPath: indexPath)
        case CellIndex.Overview.description: return getOverviewCell(tableView: tableView, indexPath: indexPath)
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 { return 140 }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
}

extension DetailEpisodeViewController {
    
    func getImageCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDetailSerieTableViewCell", for: indexPath) as? ImageDetailSerieTableViewCell
        
        cell?.configureImage(imdb: episode?.imdb ?? "")
        
        return cell!
    }
    
    func getActionCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionEpisodeTableViewCell", for: indexPath) as? ActionEpisodeTableViewCell
        
        cell?.configureCell(serie: serie, episode: episode)
        
        return cell!
    }
    
    func getInfosCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfosEpisodeTableViewCell", for: indexPath) as? InfosEpisodeTableViewCell
        
        cell?.configureCell(episode: episode)
        
        return cell!
    }
    
    func getOverviewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OverviewTableViewCell
        
        cell?.label.text = episode.overview
        
        return cell!
    }
    
}

