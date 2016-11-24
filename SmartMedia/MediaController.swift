//
//  MediaController.swift
//  SmartMedia
//
//  Created by Soulier Antoine on 24/11/2016.
//  Copyright © 2016 antoine.soulier. All rights reserved.
//

import Foundation
import UIKit

class MediaController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // @IBOutlet weak var listFilm: UITableView!
    // var movies:[Results] = []
    @IBOutlet weak var listSound: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listSound.dataSource = self
        listSound.delegate = self
        listSound.register(UINib(nibName: "MediaCell", bundle: nil), forCellWithReuseIdentifier: "soundCell");
        /*
         listFilm.dataSource = self
         listFilm.delegate = self
         listFilm.register(UINib(nibName: "FilmCell", bundle: nil), forCellReuseIdentifier: "filmCell")
        */
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // code
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // code
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "soundCell", for: indexPath) as! MediaCellController;
        item.label.text = "foo";
        
        return item;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
        
    }
/*
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as! FilmCellController
     
     let film = self.movies[indexPath.row]
     
     cell.nom.text = film.title
     cell.realisateur.text = film.director
     cell.annee.text = film.year
     cell.plot.text = film.plot
     cell.affiche.downloadedFrom(link: (film.poster))
     
     return cell
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     }
     
     func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Supprimer"
     }
     
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {}
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
     }
 */
    
}
