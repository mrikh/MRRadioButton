//
//  ViewController.swift
//  RadioButtonExample
//
//  Created by Mayank Rikh on 19/02/19.
//  Copyright © 2019 Mayank Rikh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainTableView: MRRadioButton!
    @IBOutlet weak var radioButton: MRRadioButton!

    private var selectedIndexes = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func mainRadioAction(_ sender: MRRadioButton) {

        sender.updateSelection(select: true, animated: true)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 200
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "radioCell") as? RadioCell else {return UITableViewCell()}

        cell.radioButton.updateSelection(select: selectedIndexes.contains(indexPath.row))

        cell.radioClick = { [weak self] in
            self?.selectedIndexes.append(indexPath.row)
        }

        return cell
    }
}

class RadioCell : UITableViewCell{

    @IBOutlet weak var radioButton: MRRadioButton!
    var radioClick : (()->())?

    @IBAction func radioAction(_ sender: MRRadioButton) {

        sender.updateSelection(select: true, animated: true)
        radioClick?()
    }
}
