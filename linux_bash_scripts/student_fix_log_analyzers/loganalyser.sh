#!/bin/bash
# ./loganaylser.sh filename
# Contributors: Ian , Krupesh, Zachary

if [ -z "$1" ]; then 
  echo "The proper usage is: $0 <fix_log_file>" 
  exit 1
fi

file="$1"

#Based on the input file given by the user, we created a two variables to hold a temporary files that we will parse and then later format!
output="parsedinput.txt"
finaldata="finaldata.csv"

#Filter by 35=8, 55, 54, 31, 32: These are the fix indexes that are required to get the symbol,sell/buy, stock numbers and then stock price. 
#We first grep with fix code 35=8 which is really the only index that contains completed trade info. Then grep to exclude any fix code with 32=0 as that implies no shares were sold/bought.
grep -E "35=8" "$file" | grep -Ev "32=0"| awk '{
    sym=""; side=""; price=""; qty=""; #we create variables with empty strings
    n = split($0, fields, ";") #this part will split the log file based on the ;, since the original file splits each section using ;
    for(i=1;i<=n;i++){
        gsub(/^ +| +$/,"",fields[i])   # trim leading/trailing spaces
        split(fields[i], kv, "=")
        if(kv[1]=="55") sym=kv[2]
        else if(kv[1]=="54") side=kv[2]
        else if(kv[1]=="31") price=kv[2]
        else if(kv[1]=="32") qty=kv[2]
#here what we are doing is storing the keyvalue pairs based on the index code we are interested in. 
    }
    if(sym!="" && side!="" && price!="" && qty!="") print sym","side","price","qty

}' > "$output" #this is the first file that gets the parsed data and removes all the unnecessary data.


#Here we awk to get the required averages and sums. Essentially, we split into bought shares/sold shares.
awk -F, '{
  if($2==1){buyQty[$1]+=$4; buySum[$1]+=$3*$4}
  if($2==2){sellQty[$1]+=$4; sellSum[$1]+=$3*$4}
}
END{
  print "Symbol,TotalBought, AvgBuyPrice, TotalSold, AvgSellPrice"
  for(s in buyQty){
    avgB = buySum[s]/buyQty[s] 
    avgS = (sellQty[s]>0 ? sellSum[s]/sellQty[s] : 0) 
    totalS = (sellQty[s]>0 ? sellQty[s] : 0)
    print s","buyQty[s]","avgB","totalS","avgS
    } 
  for(s in sellQty){
    if(!(s in buyQty)){
          avgS = sellSum[s]/sellQty[s] 
          print s",0,0,"sellQty[s]","avgS
    }
  }
}' "$output" > "$finaldata"
#At this part we have the final file that just needs to be formatted!

column -t -s, $finaldata


