i=0
while IFS=';' read -u 3 v1 v2 v3 v4 v5; do
  if [[ $i == 0 ]]; then
    k1="$v1"
    k2="$v2"
    k3="$v3"
    k4="$v4"
    k5="$v5"
  else
    echo # keep things pretty
    echo $k1: $(tput setaf 1)$v1$(tput sgr0);
    echo $k2: $v2;
    echo $k3: $v3;
    echo $k4: $v4;
    echo $k5: $v5;
    read -n 1 -p "Remove this image? [y/N] "
    [[ $REPLY == [Yy] ]] && docker rmi $v3
    [[ -n $REPLY ]] && echo # if read gets a char instead of a \n, you want to echo a \n to keeps things pretty
  fi
  i=$(($i+1))
done 3< <(docker images | awk -F '  +' '{OFS=";"; print $1,$2,$3,$4,$5}')
