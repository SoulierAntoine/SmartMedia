//
//  MediaController.swift
//  SmartMedia
//
//  Created by Soulier Antoine on 24/11/2016.
//  Copyright © 2016 antoine.soulier. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

extension MediaController: UITableViewDelegate, UITableViewDataSource {
    
    // Load tableView cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "soundCell", for: indexPath) as! MediaCellController;
        let result = self.results[indexPath.row]
        
        cell.icon.image = #imageLiteral(resourceName: "play-button-32")
        cell.label.text = result.title;
        
        return cell
    }
    
    // Play / Stop song
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MediaCellController
        
        if (cell.icon.image == #imageLiteral(resourceName: "play-button-32")) {
            cell.icon.image = #imageLiteral(resourceName: "pause-32")
            self.results[indexPath.row].isPlaying = false
        } else {
            cell.icon.image = #imageLiteral(resourceName: "play-button-32")
            self.results[indexPath.row].isPlaying = true
        }
        
        // Set remote server URL
        let audioFile = cell.label.text;
        let audioFileEncoded = audioFile?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed);
        let ext = self.results[indexPath.row].ext;
        let url = URL(string: "http://localhost:8080/api/audio/download?file=" + audioFileEncoded! + DOT + ext);
        
        // Set local destination URL
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let destinationURL = documentsDirectory.appendingPathComponent(Constants.APP_NAME + SLASH + audioFile! + DOT + ext);
        
        // If file already exists, don't download and just play it
        if (FileManager.default.fileExists(atPath: destinationURL.path)) {
            self.playMusic(audioFilePath: destinationURL, row: indexPath.row)
        } else {
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)
            let request = try! URLRequest(url: url!);
            
            // Download sound in a temp file, and move it to the user's fs
            session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                if error == nil {
                    if ((response as? HTTPURLResponse)?.statusCode) != nil {
                        
                        do {
                            try FileManager.default.copyItem(at: tempLocalUrl!, to: destinationURL)
                        } catch (let writeError) {
                            print("error writing file \(destinationURL) : \(writeError)")
                        }
                        
                        self.playMusic(audioFilePath: destinationURL, row: indexPath.row)
                    } else {
                        print("An error occured while retrieving the file from the server")
                    }
                } else {
                    print("Error : \(error.debugDescription)")
                }
            }.resume()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MediaCellController;
        
        
        if  (cell.icon.image == #imageLiteral(resourceName: "pause-32")) {
            cell.icon.image = #imageLiteral(resourceName: "play-button-32")
            self.results[indexPath.row].isPlaying = false
        }
        
        // Stop player when switching between rows
        stopPlayer()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }

}

class MediaController : UIViewController {
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var listSound: UITableView!
    @IBOutlet weak var addSound: UIButton!
    
    var results:[Sound] = []
    private var player: AVAudioPlayer?
    fileprivate let DOT:String = "."
    fileprivate let SLASH:String = "/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constants.APP_NAME
        
        imageLogo.image = #imageLiteral(resourceName: "smartmedia");
        imageLogo.contentMode = .scaleAspectFit;
        
        listSound.dataSource = self
        listSound.delegate = self
        listSound.register(UINib(nibName: "MediaCell", bundle: nil), forCellReuseIdentifier: "soundCell")
        listSound.separatorStyle = .none

        // addSound.setTitle(NSLocalizedString("ADD_SOUND", comment: ""), for: .normal)
        
        self.results = [];

        
        
        /*******************************/
        /* Create SmartMedia directory */
        /*******************************/
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let appFolder = documentsDirectory.appendingPathComponent(Constants.APP_NAME)
        
        print("App folder: \(appFolder)")
        
        if (!FileManager.default.fileExists(atPath: appFolder.path)) {
            do {
                try FileManager.default.createDirectory(atPath: appFolder.path, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print("Error creating directory: \(error.localizedDescription)")
            }
        }
    }
    
    public class func multiply(a: Int, b: Int) -> Int {
        return a * b
    }

    
    
    /*******************************/
    /* Get audio files from server */
    /*******************************/
    
    func fetchData() {
        let url = URL(string: Constants.DEFAULT_HOST + Constants.Operation.GET_SONG);
        
        URLSession.shared.dataTask(with: url!) { (d :Data?, r: URLResponse?, e: Error?) in
            DispatchQueue.main.async {
                if e == nil {
                    if let data = d {
                        do {
                            let objects = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject];
                            let response = objects["response"] as? String;
                            
                            if (response == "True") {
                                let files = objects["files"] as! [[String:Any]]
                                
                                for file in files {
                                    self.results.append(Sound(
                                        title: file["title"] as! String,
                                        ext: file["extension"] as! String,
                                        isPlaying:false
                                    ));
                                }
                                
                                self.listSound.reloadData()
                            } else {
                                print("The response returned from the server was falsy")
                            }
                        } catch {}
                    } else {
                        print("No data were sent back from the server")
                    }
                } else {
                    print("No internet connection")
                }
            }
        }.resume();
    }
    
    
    @IBAction func addSoundClick(_ sender: Any) {
        let vc = UploadController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.results = []
        fetchData()
        self.listSound.reloadData()
    }
    
    func playMusic(audioFilePath:URL, row:Int) {
        // If the row selected is the same and is playing, stop the player
        if (results[row].isPlaying) {
            stopPlayer()
        } else {
            if let player = try? AVAudioPlayer(contentsOf: audioFilePath) {
                player.prepareToPlay()
                player.play()
                self.player = player
            } else {
                print("File not found")
            }
        }
    }
    
    func stopPlayer() {
        if (self.player != nil) {
            if (self.player?.isPlaying)! {
                self.player?.stop()
            }
        }
    }
}
