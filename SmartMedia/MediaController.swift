//
//  MediaController.swift
//  SmartMedia
//
//  Created by Soulier Antoine on 24/11/2016.
//  Copyright © 2016 antoine.soulier. All rights reserved.
//

import Foundation
import UIKit
import Material
import AVFoundation

class MediaController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listSound: UITableView!
    @IBOutlet weak var addSound: UIButton!
    
    var results:[Sound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SmartMedia"
        
        listSound.dataSource = self
        listSound.delegate = self
        listSound.register(UINib(nibName: "MediaCell", bundle: nil), forCellReuseIdentifier: "soundCell")
        
        private var player: AVAudioPlayer?
        
        self.results = [];
        let url = URL(string: "http://localhost:8080/api/audio/list");
        
        URLSession.shared.dataTask(with: url!) { (d :Data?, r: URLResponse?, e: Error?) in
            DispatchQueue.main.async {
                 if e == nil {
                    if let data = d {
                        do {
                            let objects = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject];
                            let response = objects["response"] as? String;
                 
                            if (response == "True") {
                                // let files = objects["files"] as! [String];
                 
                                /* for file in files {
                                    print("Title : \(file)");
                                    self.results.append(file);
                                } */
                                
                                let files = objects["files"] as! [[String:Any]]
                                
                                for file in files {
                                    self.results.append(Sound(
                                        title: file["title"] as! String,
                                        ext: file["extension"] as! String
                                    ));
                                }
                 
                                self.listSound.reloadData()
                            } else {
                                // self.erreur.text = "Aucun résultat"
                            }
                        } catch {}
                    } else {
                        print("No data were sent back from the server")
                        // self.alert(title: "Mille millions de mille sabord !", message: "Aucune donnée n'a été renvoyée par le serveur. On dirait bien que ce trésor restera introuvable !")
                    }
                 } else {
                    print("No internet connection")
                    // self.alert(title: "Tonnerre de Brest !", message: "Aucune connexion internet ! On se croirait abandonné sur une île déserte...")
                 }
            }
        }.resume();
        
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
        let result = self.results[indexPath.row]
        
        cell.icon.image = Icon.cm.play;
        cell.label.text = result.title;
        // cell.extension.text = result.ext

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! MediaCellController
        
        if  (cell.icon.image == Icon.cm.play) {
            cell.icon.image = Icon.cm.pause
        } else {
            cell.icon.image = Icon.cm.play
        }
        
        let url = URL(string: "http://localhost:8080/api/audio/download?file=Breaking%20Away.ogg");
        //let nomEscaped = nom.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        // let url = URL(string: "http://www.omdbapi.com/?s=" + nomEscaped! + "&plot=short&r=json")
        
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = try! URLRequest(url: url!);
        
        session.downloadTask(with: request) { (tempLocalUrl, response, error) in
        
            // if let tempLocalUrl = tempLocalUrl, error == nil {
            if error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Success: \(statusCode)")
                    print("Response: \(response)")
                    print("File: \(tempLocalUrl)")
                }
         
                if let musicURL = Bundle.main.url(forResource: "Breaking Away", withExtension: "ogg") {
                    if let player = try? AVAudioPlayer(contentsOf: musicURL) {
                        player.play()
                        player.numberOfLoops = -1 // never stops
                        self.player = player
                    }
                }
                
                // do {
                    // try FileManager.default.copyItem(at: tempLocalUrl!, to: url!)
                    // completion()
                // } catch (let writeError) {
                    //print("error writing file \(localUrl) : \(writeError)")
                // }
            } else {
                print("Error : \(error.debugDescription)")
            }
        }.resume()
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MediaCellController;
        
        if  (cell.icon.image == Icon.cm.pause) {
            cell.icon.image = Icon.cm.play
            // tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }

}
