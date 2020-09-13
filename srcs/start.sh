#!bin/bash
clear
echo ""
echo "-------------------------------------------------------"
echo "---------------  WELCOME TO FT_SERVER  ----------------"
echo "---------------      By: Elian RC      ----------------"
echo "-------------------------------------------------------"
echo ""
echo "_______________   [ BUILDING IMAGE ]   ________________"
echo ""
docker build -t ft_server .
echo "_______________  [ RUNNING CONTAINER ] ________________"
# docker run