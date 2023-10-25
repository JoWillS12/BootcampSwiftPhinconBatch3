import UIKit

protocol WelcomeMessage {
    func welcome()
}

class ATMmachine: WelcomeMessage {
    
    enum Menu: Int {
        case Deposit = 1, Withdraw, Balance, Exit
    }
    enum ErrorPing: Error{
        case Limit
    }
    
    var originPass = 13579
    var depo: Int
    var balance: Int
//    private var _wDraw: Int = 0
    var wDraw: Int
//    {
//        get {
//            return _wDraw
//        }
//        set {
//            if newValue <= balance {
//                _wDraw = newValue
//            }
//        }
//    }
    
    init() {
        depo = 500
        balance = 2000
        wDraw = 300
    }
}

extension ATMmachine {
    func welcome() {
        print("===== WELCOME USER =====")
        print("========================")
    }
    
    func detectInput(menu: Int) {
        if let input = Menu(rawValue: menu) {
            switch input {
            case .Deposit:
                add()
            case .Withdraw:
                do {
                    try min()
                } catch {
                    print("Insufficient balance for withdrawal")
                }
            case .Balance:
                check()
            case .Exit:
                exit()
            }
        } else {
            print("Invalid Menu.")
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
        if balance >= wDraw {
            print("YOU WITHDREW $\(wDraw)")
            balance -= wDraw
            print("YOUR BALANCE IS $\(balance)")
        } else {
            throw ErrorPing.Limit
        }
    }
    
//    func min() throws {
//        if balance >= wDraw {
//            print("YOU WITHDREW $\(wDraw)")
//            balance -= wDraw
//            print("YOUR BALANCE IS $\(balance)")
//        } else {
//            throw NSError(domain: "ATMErrorDomain", code: 1, userInfo: ["message": "Insufficient balance for withdrawal"])
//        }
//    }
    
    func exit() {
        print("======= THANKYOU =======")
    }
}

let a = ATMmachine()
//a.wDraw = 5000
a.welcome()
a.detectInput(menu: 2) // Attempting a withdrawal


