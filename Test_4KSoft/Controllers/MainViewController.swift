//
//  MainViewController.swift
//  Test_4KSoft
//
//  Created by  Sasha Khomenko on 10.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private var doors: [Door] = []
    
    private let myDoorsTable: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.register(DoorTableViewCell.self, forCellReuseIdentifier: DoorTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(myDoorsTable)
    
        myDoorsTable.delegate = self
        myDoorsTable.dataSource = self
        myDoorsTable.tableHeaderView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 250))
        
        setupNavigationTitle()
        fetchData()
    }
    
    private func fetchData() {
        JsonManager.shared.fetchEquipment { [weak self] result in
            self?.doors = result
            self?.myDoorsTable.reloadData()
        } failure: { error in
            print(error)
        }
    }
    
    private func setupNavigationTitle() {
        let navBarImage: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "TitelImage")
            image.contentMode = .scaleAspectFill
            return image
        }()
        
        let imageItem = UIBarButtonItem(customView: navBarImage)
        self.navigationItem.setLeftBarButton(imageItem, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myDoorsTable.frame = view.bounds
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DoorTableViewCell.identifier) as? DoorTableViewCell else { return UITableViewCell() }
        cell.setupView(model: doors[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = myDoorsTable.cellForRow(at: indexPath) as! DoorTableViewCell
        cell.clickDoor()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "My Doors"
        return title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont(name: "Gill Sans Bold", size: 23)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y - 20,
                                         width: 200,
                                         height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.alpha = 0.7
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
}
