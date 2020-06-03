define buffer newcustomer for customer.
define buffer neworder for order.
define buffer neworderline for orderline.

disable triggers for load of customer.
disable triggers for load of order.
disable triggers for load of orderline.

define variable topCustNum as integer no-undo.
define variable i as integer no-undo.

find last customer no-lock.
topCustNum = customer.custnum.

repeat i = 1 to 59:
    for each customer where custnum <= topCustNum:
        create newcustomer.
        buffer-copy customer except custnum to newcustomer.
        assign
            newcustomer.custnum = NEXT-VALUE(NextCustNum).
        display newcustomer.custnum format ">>>,>>9".
        pause 0 before-hide.

        for each order of customer:
            create neworder.
            buffer-copy order except ordernum custnum to neworder.
            assign
                neworder.ordernum = NEXT-VALUE(NextOrdNum)
                neworder.custnum = newcustomer.custnum.

            for each orderline of order:
                create neworderline.
                buffer-copy orderline except ordernum to neworderline.
                assign
                    neworderline.ordernum = neworder.ordernum.
            end.
        end.
    end.
end.
quit.
