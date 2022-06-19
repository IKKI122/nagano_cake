class Order < ApplicationRecord
    enum payment_method: { 
        credit_card: 0, 
        transfer: 1 
    }
    
    enum status: { 
        waiting: 0, 
        paid_up: 1,
        working: 2,
        preparing: 3,
        shipped: 4
    }
end
