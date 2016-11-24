//
//  MediaController.swift
//  SmartMedia
//
//  Created by Soulier Antoine on 24/11/2016.
//  Copyright © 2016 antoine.soulier. All rights reserved.
//

import Foundation
import UIKit

class MediaController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listSound: UITableView!
    @IBOutlet weak var addSound: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SmartMedia"
        
        
        // goForm.setTitle("Ajouter un film", for: .normal)
        
        
        listSound.dataSource = self
        listSound.delegate = self
        listSound.register(UINib(nibName: "MediaCell", bundle: nil), forCellReuseIdentifier: "soundCell")
        
        // self.listFilm.rowHeight = 130
        // self.listFilm.separatorStyle = .none
        
        // fetchFilms()
        /* if (self.movies.count == 0) {
            yarr.text = "Yarr, mousaillon !"
        } */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // self.movies = []
        // fetchFilms()
        // self.listFilm.reloadData()
    }
    
    /* func fetchFilms() {
        let request = NSFetchRequest<Movie>(entityName: "Movie")
        let storeResult = try? self.context?.execute(request) as! NSAsynchronousFetchResult<Movie>
        
        for film in (storeResult?.finalResult)! {
            let r = Results(
                title: film.title!,
                poster: film.poster!,
                type: film.type!,
                year: film.year!,
                imdbID: film.imdbID!)
            r.plot = film.plot
            r.director = film.director
            
            self.movies.append(r)
        }
    } */
    
    /* @IBAction func ButtonClick(_ sender: AnyObject) {
        let vc = TestController();
        self.navigationController?.pushViewController(vc, animated: true)
    } */
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "soundCell", for: indexPath) as! MediaCellController;
        
        cell.label.text = "foo";
        /* let film = self.movies[indexPath.row]
        
        cell.nom.text = film.title
        cell.realisateur.text = film.director
        cell.annee.text = film.year
        cell.plot.text = film.plot
        cell.affiche.downloadedFrom(link: (film.poster)) */
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return movies.count
        return 1;
    }

}
