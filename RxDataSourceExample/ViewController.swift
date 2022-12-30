//
//  ViewController.swift
//  RxDataSourceExample
//
//  Created by Engineer on 30/12/22.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import RxDataSources

final class ViewController: UIViewController {

    private let disposeBag = DisposeBag()

    // you can set data in viewModel. I put data in here just for example.
    private let _sectionModels = BehaviorRelay<[SectionModel]>(value: [])
    private var sectionModels: Driver<[SectionModel]> {
        _sectionModels.asDriver()
    }

    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(FirstTVC.self, forCellReuseIdentifier: "first")
        table.register(SecondTVC.self, forCellReuseIdentifier: "second")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        retrieveData()
        bindData()
    }

    private func setupViews() {
        title = "Home"
        view.backgroundColor = .white
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }

    private func retrieveData() {
        let sectionOne = SectionModel
            .sectionOne(items: [
                .exampleFirstItem(viewModel: FirstCellViewModel(title: "Section 1"))
            ])
        let sectionTwo = SectionModel
            .sectionTwo(items: [
                .exampleSecondItem(viewModel: SecondCellViewModel(descriptionText: "Section 2"))
            ])

        let resultSectionModels = [sectionOne, sectionTwo]
        _sectionModels.accept(resultSectionModels)
    }

    private func bindData() {

        tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)

        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel>(
            configureCell: { dataSource, tableView, indexPath, _ in
                switch dataSource[indexPath] {
                case .exampleFirstItem(let viewModel):
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: "first",
                        for: indexPath) as! FirstTVC
                    cell.viewModel = viewModel
                    return cell
                case .exampleSecondItem(let viewModel):
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: "second",
                        for: indexPath) as! SecondTVC
                    cell.viewModel = viewModel
                    return cell
                }
            })

        sectionModels
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}

extension ViewController: UITableViewDelegate {
    // Add function tableview you want delegate to viewController
}
