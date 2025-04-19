//
//  DistrictViewController.swift
//  TabliceRejestracyjne
//
//  Created by Bartłomiej Prędki on 23/10/2023.
//

import UIKit

class DistrictViewController: UITableViewController {
    
    private var districtArray:[String] = []
    private var selectedDistrict = ""
    var selectors:[String] = []
    var selectedVoivodship: String?
    
    var districts:NSDictionary? {
        didSet {
            for k in districts!.allKeys {
                if let d = k as? String {
                    if d != "wyr" {
                        districtArray.append(d)
                    }
                }
                districtArray.sort { $0.compare($1, locale: NSLocale.current) == .orderedAscending }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return districtArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDistrict", for: indexPath) as! DistrictTableViewCell

        let districtName = districtArray[indexPath.row]
        cell.powLabel.text = districtName

        if let plates = districts?[districtName] as? [String],
           let firstPlate = plates.first,
           let prefix = selectors.first {
            
            let fullPlate = "\(prefix)\(firstPlate)" // np. P + GN = PGN
            if let image = UIImage(named: fullPlate) {
                cell.districtImg.image = image
            } else {
                print("❌ Brak obrazka dla: \(fullPlate)")
                cell.districtImg.image = UIImage(named: "placeholder")
            }
        } else {
            cell.districtImg.image = UIImage(named: "placeholder")
        }

        return cell
    }


    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDistrict = districtArray[indexPath.row]
        performSegue(withIdentifier: "segueDetails", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            if let plates = districts?[selectedDistrict] as? NSArray {
                destination.plates = plates
                destination.selectors = selectors
                destination.title = selectedDistrict
                destination.selectedVoivodship = selectedVoivodship
                destination.selectedDistrict = selectedDistrict
            }
        }
    }


}
