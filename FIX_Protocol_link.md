### Link to the FIX protocol Dictionary
https://www.onixs.biz/fix-dictionary/4.4/fields_by_tag.html
https://www.onixs.biz/fix-dictionary/5.0/fields_by_tag.html

***

## 📄 **Example FIX Log: New Order – Single (MsgType = D)**

```text
8=FIX.4.4|9=178|35=D|49=BUY_SIDE|56=SELL_SIDE|34=215|
52=20260306-13:12:45.123|11=ORD123456|21=1|55=AAPL|54=1|
38=100|40=2|44=182.50|59=0|10=072|
```

### 🔍 Breakdown of key fields:

| Tag    | Meaning      | Example Value           |
| ------ | ------------ | ----------------------- |
| **8**  | BeginString  | FIX.4.4                 |
| **9**  | BodyLength   | 178                     |
| **35** | MsgType      | D = New Order - Single  |
| **49** | SenderCompID | BUY\_SIDE               |
| **56** | TargetCompID | SELL\_SIDE              |
| **34** | MsgSeqNum    | 215                     |
| **52** | SendingTime  | 20260306-13:12:45.123   |
| **11** | ClOrdID      | ORD123456               |
| **21** | HandlInst    | 1 = Automated execution |
| **55** | Symbol       | AAPL                    |
| **54** | Side         | 1 = Buy                 |
| **38** | OrderQty     | 100                     |
| **40** | OrdType      | 2 = Limit               |
| **44** | Price        | 182.50                  |
| **59** | TimeInForce  | 0 = Day                 |
| **10** | Checksum     | 072                     |

***

## 📄 **Example Execution Report (MsgType = 8)**

```text
8=FIX.4.4|9=201|35=8|49=SELL_SIDE|56=BUY_SIDE|34=216|
52=20260306-13:12:45.456|37=EX123987|17=EXECRPT456|20=0|
150=0|39=0|55=AAPL|54=1|38=100|40=2|44=182.50|
151=100|14=0|6=0|11=ORD123456|10=183|
```

### 🔍 Notable tags for Execution Reports:

| Tag        | Meaning             | Example    |
| ---------- | ------------------- | ---------- |
| **35 = 8** | Execution Report    |            |
| **150**    | ExecType = 0 (New)  |            |
| **39**     | OrdStatus = 0 (New) |            |
| **37**     | OrderID             | EX123987   |
| **17**     | ExecID              | EXECRPT456 |
| **151**    | LeavesQty           | 100        |
| **14**     | CumQty              | 0          |

***
