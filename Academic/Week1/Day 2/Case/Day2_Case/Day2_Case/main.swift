//
//  main.swift
//  Day2_Case
//
//  Created by Joseph William Santoso on 24/10/23.
//

import Foundation

protocol WelcomeMessage {
    func welcome()
}

class ATMmachine: WelcomeMessage {
    
    enum Menu: Int {
        case Deposit = 1, Withdraw, Balance, Exit
    }
    enum ErrorPing: Error {
        case Limit
        case InvalidInput
    }
    
    var depo: Int
    var balance: Int
    var wDraw: Int
    
    init() {
        balance = 2000
        depo = 0
        wDraw = 0
    }
}

extension ATMmachine {
    func welcome() {
        print("===== WELCOME USER =====")
        print("========================")
    }
    
    func displayMenu() {
        print("Menu:")
        print("1. Deposit")
        print("2. Withdraw")
        print("3. Balance")
        print("4. Exit")
    }
    
    func detectInput() {
        displayMenu()
        print("Enter the menu number:")
        
        if let input = readLine(), let menuNumber = Int(input) {
            if let inputMenu = Menu(rawValue: menuNumber) {
                switch inputMenu {
                case .Deposit:
                    readDepositAmount()
                    add()
                case .Withdraw:
                    readWithdrawAmount()
                    do {
                        try min()
                    } catch ErrorPing.Limit {
                        print("Insufficient balance for withdrawal")
                    } catch ErrorPing.InvalidInput {
                        print("Invalid input. Please enter a valid withdrawal amount.")
                    } catch {
                        print("An unknown error occurred.")
                    }
                case .Balance:
                    check()
                case .Exit:
                    exit()
                }
            } else {
                print("Invalid menu option.")
            }
        } else {
            print("Invalid input. Please enter a valid menu number.")
        }
    }
    
    func readDepositAmount() {
        print("Enter the amount to deposit:")
        if let input = readLine(), let depositAmount = Int(input) {
            depo = depositAmount
        }
    }
    
    func readWithdrawAmount() {
        print("Enter the amount to withdraw:")
        if let input = readLine(), let withdrawalAmount = Int(input) {
            wDraw = withdrawalAmount
        }
    }
    
    func add() {
        print("YOU DEPOSITED $\(depo)")
        balance += depo
        print("YOUR BALANCE IS $\(balance)")
    }
    
    func check() {
        print("YOUR BALANCE IS $\(balance)")
    }
    
    func min() throws {
        if wDraw > 0 && wDraw <= balance {
            print("YOU WITHDREW $\(wDraw)")
            balance -= wDraw
            print("YOUR BALANCE IS $\(balance)")
        } else if wDraw <= 0 {
            throw ErrorPing.InvalidInput
        } else {
            throw ErrorPing.Limit
        }
    }
    
    func exit() {
        print("======= THANK YOU =======")
    }
}

let a = ATMmachine()
a.welcome()
a.detectInput()






