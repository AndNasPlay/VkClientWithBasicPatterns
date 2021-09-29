//
//  GroupsTableViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 22.09.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {

	let requestFactory: RequestFactory
	init(requestFactory: RequestFactory) {
		self.requestFactory = requestFactory
		super.init(nibName: nil, bundle: nil)
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	private let groupsViewModelFactory = GroupsViewModelFactory()
	private var groupsViewModels: [GroupsViewModel] = []
	private var tableCellHeight: CGFloat = 70.0

	private func loadData() {
		self.requestFactory.makeLoadGroupsRequestFactory().loadGroups(count: 20) { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let catalog):
					guard catalog.response?.items?.count ?? 0 > 0 else { return }
					// swiftlint:disable force_unwrapping
					self.groupsViewModels = self.groupsViewModelFactory.constructViewModel(from: (catalog.response?.items)!)
					// swiftlint:enable force_unwrapping
						self.tableView.reloadData()
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white
		self.title = "Все сообщества"
		self.tableView.separatorColor = UIColor.white
		loadData()
		self.tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.identifier)
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		groupsViewModels.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// swiftlint:disable force_cast
		let cell = self.tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.identifier,
													  for: indexPath) as! GroupsTableViewCell
		// swiftlint:enable force_cast
		cell.configureCell(groupsViewModel: groupsViewModels[indexPath.row])
		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		tableCellHeight
	}
}
