//
//  MainViewController.swift
//  Test_4KSoft
//
//  Created by  Sasha Khomenko on 10.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private var doors: [Door] = []
    
    // MARK: UI Objects
    
    private let loadIndicator = UIActivityIndicatorView()
    
    private let myDoorsTable: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.register(DoorTableViewCell.self, forCellReuseIdentifier: DoorTableViewCell.identifier)
        return table
    }()
    
    private let navBarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "TitelImage")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let settingsBtn:UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 0.3
        button.layer.cornerRadius = 13
        button.setImage(UIImage(named: "SettingBtn"), for: .normal)
        button.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationTitle()
        fetchData()
    }
    
    // MARK: View Methods
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(myDoorsTable)
        view.addSubview(loadIndicator)
        myDoorsTable.delegate = self
        myDoorsTable.dataSource = self
        myDoorsTable.tableHeaderView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 250))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myDoorsTable.frame = view.bounds
        loadIndicator.frame = view.bounds
    }
    
    // MARK: Private methods
    
    //Fetching data from Json
    private func fetchData() {
        loadIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            JsonManager.shared.fetchData { [weak self] result in
                self?.loadIndicator.stopAnimating()
                self?.doors = result
                self?.myDoorsTable.reloadData()
            } failure: { error in
                print(error)
            }
        }
    }
    
    // Setting NavigationBar
    private func setupNavigationTitle() {
        let buttonItem = UIBarButtonItem(customView: settingsBtn)
        let imageItem = UIBarButtonItem(customView: navBarImage)
        navigationItem.setRightBarButton(buttonItem, animated: true)
        navigationItem.setLeftBarButton(imageItem, animated: true)
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
