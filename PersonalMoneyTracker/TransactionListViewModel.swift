//
//  TransactionListViewModel.swift
//  PersonalMoneyTracker
//
//  Created by Şeyda Şeyma Balcı on 14.05.2022.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]


//api'dan geleecek datayı kullanmak için

final class TransactionListViewModel: ObservableObject{
        
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getTransactions()
    }
    
    
    func getTransactions(){
       guard let url = URL(string: "https://designcode.io/data/transactions.json")
        else{
           print("invalid url")
           return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
                else{
                    dump(response)//print but more readable
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder() )
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print("Error Fetching transactions", error.localizedDescription)
                case .finished:
                    print("finish fetching transcations")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
            }
            .store(in: &cancellables) //subscription cancellation

    }
    
    func groupTransactionByMonth() -> TransactionGroup{
        guard !transactions.isEmpty else {return [:] }
    
        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.month }
    
        
        return groupedTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum{
        print("accumulateTransactions")
        guard !transactions.isEmpty else { return [] }
        
        let today = "17/02/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("dateInterval", dateInterval)
    
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense}
            let dailyTotal = dailyExpenses.reduce(0) { $0-$1.signedAmount }
            
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "dailyTotal:", dailyTotal, "sum:", sum)
        }
        return cumulativeSum
    }
    
}
