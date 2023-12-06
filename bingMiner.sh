#!/bin/bash
# 09/17/2014

#accounts 


function getCoordinates
{
	sleep 7
	local x=$(xdotool getmouselocation | cut -d ' ' -f1 | tr -cd [:digit:]) 
	local y=$(xdotool getmouselocation | cut -d ' ' -f2 | tr -cd [:digit:])
	echo $x $y
}

function getWord
{
	word=$(shuf -n 1 wordsEn.txt)
	echo $word
}

function getTime
{
	time=$(( ( RANDOM % 45 )  + 15 ))
	echo $time
}


function searchInit
{
	echo "Place cursor in middle of search field and hover for 7 seconds"
	searchField=$(getCoordinates)
	echo "Search bar coordinates selected"
	echo ""
	echo "Hover your cursor over the addon arrow icon for 7 seconds"
	addon=$(getCoordinates)
	echo "Addon icon arrow coordinates selected"
	echo ""
	echo "Click addon icon arrow and hover over mobile user agent selection from list for 7 seconds"
	listSelectMobile=$(getCoordinates)
	echo "Mobile user agent coordinates selected"
	echo ""
	echo "Click addon icon arrow and hover over web user agent selection from list for 7 seconds"
	listSelectWeb=$(getCoordinates)
	echo "web user agent coordinates selected"
	echo ""
	echo "Switch user agent to mobile and hover over search bar"
	sleep 10
	mobileSearchField=$(getCoordinates)
	echo ""
	echo "Switch back to web mode and press [ENTER] to begin mining"
	read input

}

function switchUserAgentMobile
{
	xdotool mousemove $addon click 1
	sleep 2
	xdotool mousemove $listSelectMobile click 1
}

function switchUserAgentWeb
{
	xdotool mousemove $addon click 1
	sleep 2
	xdotool mousemove $listSelectWeb click 1
}

function webSearch
{
	rate="seconds"
	switchUserAgentWeb
	echo ""
    echo "Bing Miner is now in Web search mode"
    echo "#######################################"
    echo ""
    for i in {1..45}
	{
	  searchWord=$(getWord)
	  waitTime=$(getTime)
	  echo "wait time for search is" $waitTime $rate "word generated is: " $searchWord
	  xdotool mousemove $searchField click 1
	  sleep $waitTime
	  xdotool type $searchWord
	  xdotool key Return
	  xdotool mousemove $searchField click 1
	  sleep $waitTime
	  xdotool mousemove $searchField click 1
	  for i in {1..200}
 	  do
		xdotool key BackSpace;
	  done
      
	}
}

function mobileSearch
{

	rate="seconds"
    switchUserAgentMobile
    echo ""
    echo "Bing Miner is now in Mobile search mode"
    echo "#######################################"
    echo ""
    for i in {1..15}
	{
	  searchWord=$(getWord)
	  waitTime=$(getTime)
	  echo "wait time for search is" $waitTime $rate "word generated is: " $searchWord
	  xdotool mousemove $searchField click 1
	  sleep $waitTime
	  xdotool type $searchWord
	  xdotool key Return
	  xdotool mousemove $searchField click 1
	  sleep $waitTime
	  xdotool mousemove $searchField click 1
	  for i in {1..200}
 	  do
		xdotool key BackSpace;
	  done
	}
  
}

function clear
{
	rm ~/.mozilla/firefox/*.default/*.sqlite ~/.mozilla/firefox/*default/sessionstore.js
    rm -r ~/.cache/mozilla/firefox/*.default/*
}

function loginPage
{
	echo "Firefox will launch in 5 seconds"
	echo "resize how you would like"
	sleep 5
	firefox
	sleep 5
	echo "Hover cursor over address bar for 7 seconds"
	addressBar=$(getCoordinates)
	sleep 7
	echo ""
	xdotool mousemove $addressBar click 1
	  sleep 2
	  xdotool mousemove $addressBar click 1
	  for i in {1..200}
 	  do
		xdotool key BackSpace;
	  done
	  xdotool type "https://login.live.com/"
	  xdotool key Return
	  echo "place cursor on username field for 7 seconds"
	  sleep 7
	  username=$(getCoordinates)
	  echo "username login coordinates were selected"
	  echo ""
	  echo "place cursor on password field for 7 seconds"
	  sleep 7
	  password=$(getCoordinates)
	  echo "username login coordinates were selected"
	  xdotool mousemove $username click 1
	  sleep 1
	  #place username here
	  xdotool mousemove $password click 1
	  sleep 1
	  #place password here
	  xdotool mousemove $addressBar click 1
	  sleep 2
	  xdotool type "https://www.bing.com/search?q=place+cursor+in+search+field+here&qs=n&form=QBRE&pq=test+prep&sc=8-9&sp=-1&sk=&ghc=1&cvid=9bfbd8df30d84a5e808e8f8175d2f9f3"
	  xdotool mousemove $addressBar click 1
	  for i in {1..200}
 	  do
		xdotool key BackSpace;
	  done
}


function main
{   
    loginPage
    searchInit
    webSearch
    switchUserAgentMobile
    mobileSearch
    clear
}

main

