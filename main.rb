stock_prices = [17, 3, 6, 9, 15, 8, 6, 1, 10]

def stock_picker(prices)
    max = min = profit = delta = 0
    pop_min = prices.dup
    while !pop_min.empty? do
        pop_max = pop_min.dup
        while(pop_min.index(pop_min.min) == pop_min.length - 1 || pop_min.index(pop_min.max) == 0) # <= removing edge cases
            if pop_min.index(pop_min.min) == pop_min.length - 1
                pop_min.pop
            end
            if pop_min.index(pop_min.max) == 0
                pop_min.shift
            end
        end
        if pop_min.index(pop_min.min) < pop_min.index(pop_min.max) # <= exits method if min appears earlier than max to prevent wasted looping
            min = pop_min.min
            max = pop_min.max
            profit = max - min
            return "Buy at day #{prices.index(min)} and sell on day #{prices.index(max)} for a profit of $#{max} - $#{min} = $#{profit}"
        end
        while !pop_max.empty? do # <= loop for each min value test to see if there's a max that comes after
            max_index = pop_max.index(pop_max.max)
            min_index = pop_max.index(pop_max.min)
            if min_index < max_index # <= tests if min of this array appears earlier in the array than the current max
                min = pop_max.min
                max = pop_max.max
                delta = max - min
                break
            else
                pop_max.delete_at(max_index)
            end
        end
        if delta > profit # <= tests if the new delta is larger than the current perceived profit
            true_min = min
            true_max = max
            profit = delta
        end
        if profit == 0
            p "Do not buy any days"
        end
        pop_min.delete_at(pop_min.index(pop_min.min)) # <= pops out min of current array
    end
    buy_date = prices.index(true_min)
    sell_date = prices.index(true_max)
    return "Buy at day #{buy_date} and sell on day #{sell_date} for a profit of $#{true_max} - $#{true_min} = $#{profit}"
end

p stock_picker(stock_prices)