#!/bin/bash
N=$1

function fractal_tree(){
	N=${1}
	sequence=()
	iter=$2
	start_r=$3
	end_r=$((2**(6-N+1)))
	exp=''
	if [ $N -eq 1 ];then
		sequence+=(50)
	else
		for i in `seq 0 $(bc <<< "(2^(${N}-1)) - 1")`
		do
			X=50
        		Y=32
        		SIGNS=$(echo "obase=2;${i}" | bc | xargs printf "%0$((${N}-1))d\n" | sed 's/0/-/g; s/1/+/g')
        		MATH="$X"
       			VAL=$Y
        		for (( i=0; i<${#SIGNS}; i++ )); do
            			MATH+="${SIGNS:$i:1}"
            			VAL=$(bc <<< "$VAL / 2")
            			MATH+="${VAL}"
        		done
			sequence+=($(bc <<< "${MATH}"))
		done
	fi
	limit=$(($end_r-$start_r/2))
	for r in $(eval echo "{$start_r..$end_r}");do
		for c in {1..100};do
			flag=0
			for value in "${sequence[@]}";do
				if [[ $value -eq $c ]];then
					flag=1
					break
				fi
			done
			if [[ ( $r -gt $limit && $flag -eq 1 ) ]];then
				printf "1"
			elif [[  $r -le $limit ]];then
				if [[ ( $N -eq 1 && ( $r -eq $((c-2)) || $c -eq $((98-r)) )) ||( $N -eq 2 && ( $r -eq $((c-42)) || $r -eq $((c-10)) || $r -eq $((58-c)) || $r -eq $((90-c))) ) ||( $N -eq 3 && ( $r -eq $((c-14)) || $r -eq $((38-c)) || $r -eq $((c-30)) || $r -eq $((54-c)) || $r -eq $((c-46)) || $r -eq $((70-c)) || $r -eq $((c-62)) || $r -eq $((86-c)) )) ||( $N -eq 4 && ( $r -eq $((c-16)) || $r -eq $((28-c)) || $r -eq $((c-24)) || $r -eq $((36-c)) || $r -eq $((c-32)) || $r -eq $((44-c)) || $r -eq $((c-40)) || $r -eq $((52-c)) || $r -eq $((c-48)) || $r -eq $((60-c)) || $r -eq $((c-56)) || $r -eq $((68-c)) || $r -eq $((c-64)) || $r -eq $((76-c)) || $r -eq $((c-72)) || $r -eq $((84-c)) ) ) ||
					( $N -eq 5 && ($r -eq $((c-18)) || $r -eq $((22-c)) || $r -eq $((c-22)) || $r -eq $((26-c)) || $r -eq $((c-26)) || $r -eq $((30-c)) || $r -eq $((c-30)) || $r -eq $((34-c)) || $r -eq $((c-34)) || $r -eq $((38-c)) || $r -eq $((c-38)) || $r -eq $((42-c)) || $r -eq $((c-42)) || $r -eq $((46-c)) || $r -eq $((c-46)) || $r -eq $((50-c)) || $r -eq $((c-50)) || $r -eq $((54-c)) || $r -eq $((c-54)) || $r -eq $((58-c)) || $r -eq $((c-58)) || $r -eq $((62-c)) || $r -eq $((c-62)) || $r -eq $((66-c)) || $r -eq $((c-66)) || $r -eq $((70-c)) || $r -eq $((c-70)) || $r -eq $((74-c)) || $r -eq $((c-74)) || $r -eq $((78-c)) || $r -eq $((c-78)) || $r -eq $((82-c)) ) ) ]];then
					printf "1"
				else
					printf "-"
				fi
			else
				printf "-"
			fi
		done
		echo
		
	done
	N=$((N-1))
	iter=$((iter+1))
	start_r=$((end_r+1))
	if [[ $N -ge 1 ]];then
		fractal_tree $N $iter $start_r
	fi
}

if [[ $# -eq 1 ]];then
	start_r=$((2**$((6-N))))
	for r in $(eval echo "{2..$start_r}");do
		for c in {1..100};do
			printf "-"
		done
		echo
	done
	fractal_tree $N 1 $(($start_r+1))
fi
