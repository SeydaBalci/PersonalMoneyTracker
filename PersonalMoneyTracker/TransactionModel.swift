//
//  TransactionModel.swift
//  PersonalMoneyTracker
//
//  Created by Şeyda Şeyma Balcı on 14.05.2022.
//

import Foundation
import SwiftUIFontIcon


struct Transaction: Identifiable, Decodable, Hashable{
    let id: Int
    let date: String
    let institution: String
    let account: String
    let amount: Double
    let type: TransactionType.RawValue
    let isPending: Bool
    
    var merchant: String
    var category: String
    var categoryId: Int
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    var dateParsed: Date{
        date.dateParsed()
    }
    
    var signedAmount: Double{
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
    
    var month: String{
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
    
    var icon: FontAwesomeCode{
        if let category = Category.all.first (where: {$0.id==categoryId }){
            return category.icon
        }
        return .question
    }
    
}

enum TransactionType: String{
    case debit = "debit"
    case credit = "credit"
}

struct Category{
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    var mainCategoryId: Int?
    
}

extension Category{
    
    //Main Categories
    static let autoAndTransport = Category(id: 1, name: "Auto & Transport", icon: .car_alt)
    static let billsandUtilities = Category(id: 2, name: "Bills & Utilities", icon: .file_invoice_dollar)
    static let entertainment = Category(id: 3, name: "Entertainment", icon: .film)
    static let feesAndCharges = Category(id: 4, name: "Fees & feesAndCharges", icon: .hand_holding)
    static let foodAndDining = Category(id: 5, name: "Food & Dining", icon: .hamburger)
    static let home = Category(id: 6, name: "Home", icon: .home)
    static let income = Category(id: 7, name: "Income", icon: .dollar_sign)
    static let shopping = Category(id: 8, name: "Shopping", icon: .shopping_basket)
    static let transfer = Category(id: 9, name: "transfer", icon: .exchange_alt)
    //SubCategories
    static let publicTransportation = Category(id: 101, name: "Public Transportation", icon: .bus, mainCategoryId: 1)
    static let taxi = Category(id: 102, name: "Taxi", icon: .taxi, mainCategoryId: 1)
    static let mobilePhone = Category(id: 201, name: "Mobile Phone", icon: .mobile_alt, mainCategoryId: 2)
    static let moviesAndDVDs = Category(id: 301, name: "Movies & DVDs", icon: .film, mainCategoryId: 3)
    static let bankFee = Category(id: 401, name: "Bank Fee", icon: .hand_holding, mainCategoryId: 4)
    static let financeCharges = Category(id: 402, name: "Finance Charges", icon: .hand_holding, mainCategoryId: 4)
    static let groceries = Category(id: 501, name: "Groceries", icon: .shopping_bag, mainCategoryId: 5)
    static let restaurants = Category(id: 502, name: "Restaurants", icon: .utensils, mainCategoryId: 5)
    static let rent = Category(id: 601, name: "Rent", icon: .house_user, mainCategoryId: 6)
    static let homeSupplies = Category(id: 602, name: "Home Supplies", icon: .lightbulb, mainCategoryId: 6)
    static let paycheque = Category(id: 701, name: "Paycheque", icon: .dollar_sign, mainCategoryId: 7)
    static let software = Category(id: 801, name: "Software", icon: .icons, mainCategoryId: 8)
    static let creditCardPaymnet = Category(id: 901, name: "Credit Card Payment", icon: .exchange_alt, mainCategoryId: 9)
    
}

extension Category{
    static let categories: [Category] = [
            .autoAndTransport,
            .billsandUtilities,
            .entertainment,
            .feesAndCharges,
            .foodAndDining,
            .home,
            .income,
            .shopping,
            .transfer,
    ]
    
    static let subCategories: [Category] = [
        .publicTransportation,
        .taxi,
        .mobilePhone,
        .moviesAndDVDs,
        .bankFee,
        .financeCharges,
        .groceries,
        .restaurants,
        .rent,
        .homeSupplies,
        .paycheque,
        .software,
        .creditCardPaymnet,
    ]
    
    static let all: [Category] = categories + subCategories
}
