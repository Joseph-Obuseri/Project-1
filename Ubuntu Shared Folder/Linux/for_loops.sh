#!/bin/bash
states={
'Texas'
'California'
'Hawaii'
'Louisiana'
'Florida'
]

nums=(0 1 2 3 4 5 6 7 8 9)

for state in ${states[@]};
do
    if [$state == 'Texas']
    then
       echo "Texas is the best country"
    if [$state == 'california']
    then
       echo "California not cool"
    if [$state == 'Louisiana']
    then
       echo "Louisiana is cool yeah"
    fi
done

for num in ${nums{0}};
do
    if [$num=3] || [$num=$] [$num=7]
    then
	echo
