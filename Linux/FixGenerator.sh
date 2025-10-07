#!/bin/bash

#############################################
# v1.1 of script by Su Morton
# date 6/5/2020
#############################################

#writing a script to generate a fix log

# First step is to generate the logon messages

TODAY=`date "+%Y-%m-%d"`

# open the log file
LOGFILENAME="fixlog"`date "+%Y%m%d%H%M%S"`".log"

touch $LOGFILENAME

# Need to setup some of the variables we will need

CLIENT="MTHREE"
BROKER="MS"

HEARTBEAT=""
HEARTBEATRESPONSE=""

CLIENTSEQNUMBER=1
BROKERSEQNUMBER=1

CURRENTTIME=`date "+%Y-%m-%d-%T"`

# initial login messages on the session

INITIALLOGON="8=FIX4.4; 35=A; 34=$CLIENTSEQNUMBER; 49=$CLIENT; 56=$BROKER; 52=$CURRENTTIME; 108=30; 10=0015;"
INITIALLOGONACK="8=FIX4.4; 35=A; 34=$BROKERSEQNUMBER; 49=$BROKER; 56=$CLIENT; 52=$CURRENTTIME; 108=30; 10=0016;"

echo $INITIALLOGON >> $LOGFILENAME
echo $INITIALLOGONACK >> $LOGFILENAME

# now we will put some heartbeat messages in the log before trading starts - we will make the number of heart beat messages configurable
# To be authentic the sleep variable should be set to 30 in here

TOTALHEARTBEATS=50

until [ $CLIENTSEQNUMBER -gt $TOTALHEARTBEATS ]
do
        let "CLIENTSEQNUMBER++"
        let "BROKERSEQNUMBER++"
        CURRENTTIME=`date "+%Y-%m-%d-%T"`


        INITIALHEARTBEAT="8=FIX4.4; 35=0; 34=$CLIENTSEQNUMBER; 49=$CLIENT; 56=$BROKER; 52=$CURRENTTIME; 108=30; 10=0015;"
        INITIALHEARTBEATACK="8=FIX4.4; 35=0; 34=$BROKERSEQNUMBER; 49=$BROKER; 56=$CLIENT; 52=$CURRENTTIME; 108=30; 10=0015;"
        sleep 2

        echo $INITIALHEARTBEAT >> $LOGFILENAME
        echo $INITIALHEARTBEATACK >> $LOGFILENAME

done

#now we will look to setup some trading messages

Stocks=('AAPL' 'MSFT' 'AMZN' 'FB' 'GOOG' 'GOOGL' 'INTC' 'PEP' 'NFLX' 'CSCO' 'AMGN' 'PYPL' 'TSLA' 'TXN' 'AVGO' 'GILD' 'SBUX' 'QCOM' 'TMUS' 'MDLZ' 'BAC' 'DDD' 'MMM' 'WBAI' 'WUBA' 'EGHT' 'AHC' 'AOS' 'ATEN' 'AIR' 'AAN' 'ABB' 'ABT' 'ABBV' 'ANF' 'ABM' 'AAPL' 'PEP' )
Prices=('1276.37' '59.89' '133.47' '430.62' '42.05' '289.20' '339.13' '36.21' '306.71' '233.73' '116.62' '723.61' '503.77' '112.46' '262.99' '82.91' '75.71' '75.47' '90.74' '52.26' '22.03' '8.01' '146.98' '4.10' '51.41' '17.03' '1.40' '40.38' '6.45' '16.31' '25.68' '17.42' '94.04' '83.60' '9.10' '31.64' '284.65' '45.43' )


CURRENTSTOCK=""
CURRENTPRICE=""
ORDERID=""
QTY=""
TOTALNEWORDERS=`echo "${#Stocks[@]}"`
i=0
until [ $i -gt $TOTALNEWORDERS ]
do
        CURRENTSTOCK="`echo ${Stocks[$i]}`"
        CURRENTTIME=`date "+%Y-%m-%d-%T"`
        QTY="";
        SIDE=1;
        CURRENTPRICE="`echo ${Prices[$i]}`"
        ORDERID="algo"`date "+%Y%m%d%H%M%S"`
        SIDE="`echo $((1 + RANDOM % 2))`"
        QTY="`echo $(($RANDOM + 10))`"

        let "CLIENTSEQNUMBER++"

        NEWORDER="8=FIX4.4; 35=D; 34=$CLIENTSEQNUMBER; 49=$CLIENT; 56=$BROKER;  52=$CURRENTTIME; 55=$CURRENTSTOCK; 40=2; 38=$QTY; 21=2; 11=$ORDERID; 60=$CURRENTTIME; 54=$SIDE; 44=$CURRENTPRICE; 10=0252;"

        echo $NEWORDER >> $LOGFILENAME

#set up the qty variables so we can acknowledge the message
        LASTTRDQTY=0
        LASTTRDVOL=0
        EXECID="exec"`date "+%Y%m%d%H%M%S"`
        CUMQTY=0
        let "BROKERSEQNUMBER++"

        NEWORDERACK="8=FIX4.4; 35=8; 34=$BROKERSEQNUMBER; 49=$BROKER; 56=$CLIENT; 52=$CURRENTTIME; 55=$CURRENTSTOCK; 40=2; 11=$ORDERID; 31=$CURRENTPRICE; 150=0; 39=0; 54=$SIDE; 44=$CURRENTPRICE; 32=$LASTTRDVOL; 17=$EXECID; 38=$QTY; 60=$CURRENTTIME; 6=$LASTTRDQTY; 14=$CUMQTY; 37=$ORDERID; 10=200;"

        echo $NEWORDERACK >> $LOGFILENAME

        #need to setup the partial fills
        NUMBEROFFILLS=1
        NUMBEROFFILLS="`echo $((1 + RANDOM % 5))`"
        x=0

        LASTTRDQTY="`echo $(($QTY / $NUMBEROFFILLS))`"
        QTYREMAINING=0
        QTYREMAINING="`echo $(($QTY - $LASTTRDQTY))`"
        NUMBEROFPARTIALFILLS="`echo $(($NUMBEROFFILLS - 1))`"
        FILLTEST=0

        until [ $x -eq $NUMBEROFPARTIALFILLS ]
        do

                #now to chose if to fill or cancel

                CANCELTEST="`echo $((1 + RANDOM % 2))`"
                FILLTEST=0

                if [ $CANCELTEST -eq 1 ]
                then
                        EXECID="exec"`date "+%Y%m%d%H%M%S"`
                        CURRENTTIME=`date "+%Y-%m-%d-%T"`
                        CUMQTY="`echo $(($CUMQTY + $LASTTRDQTY))`"
                        let "BROKERSEQNUMBER++"

                        PARTIALFILL="8=FIX4.4; 35=8; 34=$BROKERSEQNUMBER; 49=$BROKER; 56=$CLIENT; 52=$CURRENTTIME; 55=$CURRENTSTOCK; 40=2; 11=$ORDERID; 31=$CURRENTPRICE; 150=1; 39=1; 54=$SIDE; 44=$CURRENTPRICE; 32=$LASTTRDQTY; 17=$EXECID; 38=$QTY; 60=$CURRENTTIME; 6=$CURRENTPRICE; 14=$CUMQTY; 37=$ORDERID; 10=240;"

                        echo $PARTIALFILL >> $LOGFILENAME

                        ((x=x+1))

                        QTYREMAINING="`echo $(($QTYREMAINING - $LASTTRDQTY))`"
                        FILLTEST=0
                        sleep 1

                else

                        CURRENTTIME=`date "+%Y-%m-%d-%T"`
                        CANCELORDERID="C_"`echo $ORDERID`
                        CANCELREQUEST="8=FIX4.4; 35=F; 34=$CLIENTSEQNUMBER; 49=$CLIENT; 56=$BROKER;  52=$CURRENTTIME; 41=$ORDERID; 55=$CURRENTSTOCK; 38=$QTY; 11=$CANCELORDERID; 60=$CURRENTTIME; 10=060;  "
                        echo $CANCELREQUEST >> $LOGFILENAME
                        let "CLIENTSEQNUMBER++"

                        EXECID="exec"`date "+%Y%m%d%H%M%S"`
                        CURRENTTIME=`date "+%Y-%m-%d-%T"`


                        PENDINGCANCEL="8=FIX4.4; 35=8; 34=$BROKERSEQNUMBER; 49=$BROKER; 56=$CLIENT; 52=$CURRENTTIME; 55=$CURRENTSTOCK; 11=$CANCELORDERID; 31=0; 150=6; 39=6; 54=$SIDE; 44=$CURRENTPRICE; 17=$EXECID; 32=0; 41=$ORDERID; 38=$QTY; 60=$CURRENTTIME; 6=0.0; 14=$CUMQTY; 37=$ORDERID; 10=252; "
                        echo $PENDINGCANCEL >> $LOGFILENAME
                        let "BROKERSEQNUMBER++"


                        EXECID="exec"`date "+%Y%m%d%H%M%S"`
                        CURRENTTIME=`date "+%Y-%m-%d-%T"`

                        CANCELACK="8=FIX4.4; 35=8; 34=$BROKERSEQNUMBER; 49=$BROKER; 56=$CLIENT; 52=$CURRENTTIME; 151=$QTYREMAINING; 55=$CURRENTSTOCK; 11=$CANCELORDERID; 31=0; 150=4; 39=4; 54=$SIDE; 17=$EXECID; 32=0;  41=$ORDERID; 38=$QTY; 60=$CURRENTTIME;  6=0.0; 14=$CUMQTY; 37=$ORDERID; 10=252;"

                        echo $CANCELACK >> $LOGFILENAME
                        let "BROKERSEQNUMBER++"
                        FILLTEST=1;
                        x=$NUMBEROFPARTIALFILLS
                        sleep 1

                fi

        done
        #if qty remaining is not = 0 then you need to do one more fill

        ((i=i+1))
        sleep 1

        #Now we need to send out the fully filled message if we need it
        if [ $FILLTEST -eq 0 ]
        then
                EXECID="exec"`date "+%Y%m%d%H%M%S"`
                CURRENTTIME=`date "+%Y-%m-%d-%T"`

                QTYREMAINING="`echo $(($QTY - $CUMQTY))`"
                let "BROKERSEQNUMBER++"

                FULLYFILLED="8=FIX4.4; 35=8; 34=$BROKERSEQNUMBER; 49=$BROKER; 56=$CLIENT; 52=$CURRENTTIME; 55=$CURRENTSTOCK; 40=2; 11=$ORDERID; 31=$CURRENTPRICE; 150=2; 39=2; 54=$SIDE; 44=$CURRENTPRICE; 32=$QTYREMAINING; 17=$EXECID; 38=$QTY; 60=$CURRENTTIME; 6=$CURRENTPRICE; 14=$QTY; 37=$ORDERID; 10=246;"

                echo $FULLYFILLED >> $LOGFILENAME
        fi


done