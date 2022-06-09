//
//  RickMortyViewController.swift
//  RickMortySwiftWithoutSB
//
//  Created by Erencan on 6.06.2022.
//

import UIKit
import SnapKit

protocol RickMortyOutput{
    func changeLoading(isLoad:Bool)
    func saveData (values:[Result])
    
}

final class RickMortyViewController: UIViewController {
    
    private let labelTitle:UILabel = UILabel()
    private let tableView : UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private lazy var results: [Result] = []

    lazy var viewModel:IRickMortyViewModel = RickMortyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
        // Do any additional setup after loading the view.
    }
    
    private func configure () {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        drawDesign()
        makeLabel()
        makeTableView()
        makeIndicator()
    }

    private func drawDesign(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.register(RickMortyTableViewCell.self, forCellReuseIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue)
        
        tableView.rowHeight=self.view.frame.height * 0.2
        DispatchQueue.main.async {

            self.view.backgroundColor = .white
            self.labelTitle.text = "Rick & Morty"
            self.labelTitle.textColor = .black
            self.indicator.color = .red
        }
       
        indicator.startAnimating()

    }
}

extension RickMortyViewController: RickMortyOutput {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveData(values: [Result]) {
        results = values
        tableView.reloadData()
    }
    
    
}

extension RickMortyViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RickMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue) as? RickMortyTableViewCell else {
            return UITableViewCell()
        }
//        cell.textLabel?.text = results[indexPath.row].name ?? ""
//        cell.textLabel?.textColor = .black
//        cell.backgroundColor = .white
//        cell.tintColor = .white
        cell.backgroundColor = .white
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
    
   
    
    
    
}
extension RickMortyViewController{
    
    private func makeTableView (){
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
        }
    }
    
    func makeLabel()  {
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
    func makeIndicator() {
        indicator.snp.makeConstraints { make in
            make.top.equalTo(labelTitle)
            make.top.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
        }
    }
}
