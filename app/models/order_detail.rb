class OrderDetail < ApplicationRecord
    enum making_status: { 
        unmanufacturable: 0, 
        waiting: 1,
        working: 2,
        completed: 3
    }
    
    belongs_to :item
    belongs_to :order
end
