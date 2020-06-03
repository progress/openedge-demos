etime(yes).
output to report.txt.

for each customer no-lock,
    each order no-lock
         where order.custnum = customer.custnum
           and promisedate = 06/28/2019,
    each orderline no-lock
         where orderline.ordernum = order.ordernum:
    put customer.custnum format ">>>>>9" customer.name skip.
end.

output close.
display etime.

pause.
quit.
