//
//  DetailsViewController.swift
//  TabliceRejestracyjne
//
//  Created by Krzysztof Zaporowski on 16/04/2025.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource {
    
    var plates: NSArray = []                  // Przychodzi z poprzedniego VC
    var selectors: [String] = []              // Przychodzi z poprzedniego VC
    var selectedVoivodship: String?
    var selectedDistrict: String?
    
    private var combinedPlates: [String] = [] // Docelowe tablice
    
    // MARK: - Outlety
    @IBOutlet weak var wojLabel: UILabel!
    @IBOutlet weak var powiatLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "plateCell")

        // Ustawienie etykiet
        wojLabel.text = selectedVoivodship ?? "Brak danych"
        powiatLabel.text = selectedDistrict ?? "Brak danych"
        self.title = selectedDistrict

        // Przetwarzanie danych
        loadPlates()
    }

    func loadPlates() {
        guard plates.count > 0 else {
            print("Brak plates 😢")
            return
        }

        for selector in selectors {
            for i in 0..<plates.count {
                if let plate = plates[i] as? String {
                    let full = selector + plate
                    print("Dodaję: \(full)")
                    combinedPlates.append(full)
                } else {
                    print("Nie udało się sparsować plate: \(plates[i])")
                }
            }
        }
    }


    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return combinedPlates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plateCell", for: indexPath)
        cell.textLabel?.text = combinedPlates[indexPath.row]
        return cell
    }
}

