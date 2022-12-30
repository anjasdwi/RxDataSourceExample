//
//  SectionModel.swift
//  RxDataSourceExample
//
//  Created by Engineer on 30/12/22.
//

import RxDataSources

enum ItemModel {
    case exampleFirstItem(viewModel: FirstCellViewModel)
    case exampleSecondItem(viewModel: SecondCellViewModel)
}

enum SectionModel {
  case sectionOne(items: [ItemModel])
  case sectionTwo(items: [ItemModel])
}

extension SectionModel: SectionModelType {
  typealias Item = ItemModel

  var items: [Item] {
      switch self {
      case .sectionOne(let items):
          return items
      case .sectionTwo(let items):
          return items
      }
  }

  init(original: SectionModel, items: [Item]) {
      switch original {
      case .sectionOne:
          self = .sectionOne(items: items)
      case .sectionTwo:
          self = .sectionTwo(items: items)
      }
  }
}
