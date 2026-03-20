# Grafana + Prometheus no Minikube

Stack de monitoramento com Prometheus e Grafana para deploy no Minikube.

## Pré-requisitos

- [Minikube](https://minikube.sigs.k8s.io/) instalado e rodando
- `kubectl` configurado


aplicar manifestos:

```bash
kubectl apply -f namespace.yaml
kubectl apply -f prometheus/
kubectl apply -f grafana/
```

## Acesso

### acesso kube_ip
```bash
MINIKUBE_IP=$(minikube ip)
echo "Prometheus: http://$MINIKUBE_IP:30090"
echo "Grafana:    http://$MINIKUBE_IP:30300"
```