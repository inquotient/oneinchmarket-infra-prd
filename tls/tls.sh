sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./tls.key -out ./tls.crt -subj "/CN=oneinchmarket.co.kr"
sudo kubectl create secret tls --save-config tls --key ./tls.key --cert ./tls.crt -n dev
sudo kubectl create secret generic tls-dhparam --from-file=dhparam.pem -n dev -o json --dry-run=client | jq '.metadata.labels |= {"app.kubernetes.io/name": "ingress-nginx", "app.kubernetes.io/part-of": "ingress-nginx"}' | kubectl -n dev apply -f-
sudo kubectl delete secret/tls -n dev
sudo kubectl delete secret/tls-dhparam -n dev

sudo openssl rand -hex 32
sudo openssl pkcs12 -export -in ./tls.crt -inkey ./tls.key -out keycloaks.p12
# 위의 해쉬값을 비밀번호로 사용
# keytool -importkeystore -deststorepass '암호화에 사용한 비밀번호' -destkeypass '암호화에 사용한 비밀번호' -destkeystore keycloaks.test.jks -srckeystore keycloaks.test.net.p12 -srcstoretype PKCS12 -alias 1
keytool -importkeystore -deststorepass '' -destkeypass '' -destkeystore keycloaks.keystore.jks -srckeystore keycloaks.p12 -srcstoretype PKCS12 -alias 1
keytool -importkeystore -deststorepass '' -destkeypass '' -destkeystore keycloaks.truststore.jks -srckeystore keycloaks.p12 -srcstoretype PKCS12 -alias 1
keytool -importkeystore -srckeystore keycloaks.keystore.jks -destkeystore keycloaks.keystore.jks -deststoretype pkcs12
keytool -importkeystore -srckeystore keycloaks.truststore.jks -destkeystore keycloaks.truststore.jks -deststoretype pkcs12
sudo kubectl create secret generic keycloak-store --from-file=keycloaks.truststore.jks --from-file=keycloaks.keystore.jks -n dev