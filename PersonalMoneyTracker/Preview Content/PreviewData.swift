//
//  PreviewData.swift
//  PersonalMoneyTracker
//
//  Created by Şeyda Şeyma Balcı on 14.05.2022.
//

import Foundation
import SwiftUI

var TransactionPreviewData = Transaction(id: 1, date: "23/05/2022", institution: "Yildiz Teknik Universitesi", account: "Visa YTU", amount: 11.49, type: "debit", isPending: false, merchant: "Apple", category: "Software Expense", categoryId: 801, isTransfer: false, isExpense: true, isEdited: false)


var transactionListPreviewData = [Transaction](repeating: TransactionPreviewData, count: 10)
