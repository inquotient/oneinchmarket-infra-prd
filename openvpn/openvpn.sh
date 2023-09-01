sudo kill -9 $(ps -ef | grep "kubectl -n dev port-forward svc/openvpn-nodeport" | sed -n '2p' | gawk '{ print $2"\t"$3 }')
sudo kubectl create -f openvpn-statefulset.yaml -f openvpn-nodeport.yaml -f openvpn-headless.yaml -n dev
sudo kubectl -n dev port-forward svc/openvpn-nodeport 1194:1194 > /dev/null 2>&1 &