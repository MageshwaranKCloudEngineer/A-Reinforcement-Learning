# A-Reinforcement-Learning-Approach-to-Real-Time-Cost-Aware-Kubernetes-Auto-Scaling
Implementation of an SLA-aware Kubernetes autoscaler using reinforcement learning, including the simulation environment, training scripts, evaluation notebooks, and all artefacts required to reproduce the results reported in the MSc thesis


```markdown
# SLA-Aware Kubernetes Autoscaling using Reinforcement Learning

An MSc research project implementing a reinforcement learning–based Kubernetes pod autoscaler to optimize **Service Level Agreement (SLA) compliance** while reducing resource cost.  
The project integrates:
- A custom environment for Kubernetes scaling decisions
- Live metrics from Prometheus
- A DQN-based agent trained via `keras-rl`
- Comparisons against Kubernetes HPA and VPA

---

## 📂 Repository Structure



├── ML.ipynb                         # End-to-end notebook: setup, training, evaluation
├── README.md                        # This file
├── autoscaler\_decision\_snapshot.png # Snapshot of autoscaler decision flow
├── dqn\_kube\_weights.h5               # Saved DQN model weights
├── dqn\_reward\_accuracy\_log.csv       # Step-level reward & SLA accuracy logs
├── hpa\_vpa\_rl\_simulation.csv         # Baseline vs RL simulation data
├── kind-config.yaml                  # kind cluster configuration
├── latency.png                       # Latency time-series plot
├── pd.png                            # Pod decision trends plot
├── prometheus-values.yaml            # Helm values for Prometheus setup
├── reward\_plot.png                   # Aggregate reward plot
├── training\_reward\_plot.png          # Reward during training
├── rl-testing-deployment.yaml        # RL agent Kubernetes deployment
├── rl-testing-service.yaml           # RL agent Kubernetes service
├── run\_rl\_benchmark.sh               # Benchmark script for RL vs baselines
├── synthetic\_load\_profile\_60\_chunks.csv # Synthetic workload trace
├── nginx-deploy.yaml                 # Test microservice deployment
└── workload\_steady.yaml              # Steady-state load profile descriptor

````

---

## 🚀 Quickstart

### 1. Prerequisites
- Python 3.8+ and `pip`
- Local Kubernetes cluster (e.g., kind, Minikube)
- Prometheus installed in the cluster

### 2. Setup
```bash
# Create Kubernetes cluster
kind create cluster --config kind-config.yaml

# Deploy Prometheus (Helm or manifests)
kubectl apply -f prometheus-values.yaml

# Deploy test service and RL agent
kubectl apply -f nginx-deploy.yaml
kubectl apply -f rl-testing-deployment.yaml
kubectl apply -f rl-testing-service.yaml
````

### 3. Run Experiments

```bash
bash run_rl_benchmark.sh
```

This script runs the RL-based autoscaler and collects comparison data for HPA/VPA.

### 4. Analyse Results

Open the Jupyter notebook:

```bash
jupyter notebook ML.ipynb
```

Generate figures:

* `latency.png` – latency trend vs. SLA
* `pd.png` – pod scaling decisions over time
* `reward_plot.png` – aggregated reward
* `training_reward_plot.png` – training reward progression

---

## 📊 Key Features

* **Live Prometheus metrics**: CPU, memory, latency, pod count
* **DQN agent**: SLA-aware reward function penalising latency breaches and excess replicas
* **Baselines**: HPA and VPA under the same workloads
* **Synthetic workloads** for reproducibility
* **Saved weights & logs** for transparency

---



## 🔍 Transparency & Reproducibility

* Includes all code, configuration, workloads, and results to reproduce MSc thesis figures and tables
* Saved RL model weights (`dqn_kube_weights.h5`) and logs (`dqn_reward_accuracy_log.csv`)
* Workload traces for consistent evaluation

```
