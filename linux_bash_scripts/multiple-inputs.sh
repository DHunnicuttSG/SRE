for i in "$@"; do 
if [[ "$i" =~ ^[0-9]+$ ]]; then 
echo "Contains a number" 
else 
echo "Doesn't contain a number" 
fi 
done