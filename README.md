# A-Reinforcement-Learning-Approach-to-Real-Time-Cost-Aware-Kubernetes-Auto-Scaling
Implementation of an SLA-aware Kubernetes autoscaler using reinforcement learning, including the simulation environment, training scripts, evaluation notebooks, and all artefacts required to reproduce the results reported in the MSc thesis

---

```markdown
# SLA-Aware Kubernetes Autoscaler using Reinforcement Learning

**Implementation of an SLA-aware Kubernetes autoscaler using reinforcement learning, including the simulation environment, training scripts, evaluation notebooks, and all artefacts required to reproduce the results reported in the MSc thesis.**

---

##  Repository Structure

```

├── ML.ipynb                        # Core Jupyter notebook: environment setup, training, evaluation
├── README.md                       # This file
├── autoscaler\_decision\_snapshot.png
├── dqn\_kube\_weights.h5            # Saved DQN model weights
├── dqn\_reward\_accuracy\_log.csv    # Step-level training logs: reward & SLA accuracy
├── hpa\_vpa\_rl\_simulation.csv      # Baseline vs RL simulation data
├── kind-config.yaml               # Config for local K8s using kind
├── latency.png                    # Latency time-series plot
├── pd.png                         # Possibly pod-decision-related plot
├── prometheus-values.yaml         # Helm values for Prometheus setup
├── reward\_plot.png                # Aggregate reward plot
├── training\_reward\_plot.png       # Training reward over episodes
├── rl-testing-deployment.yaml     # K8s manifest for the RL agent deployment
├── rl-testing-service.yaml        # K8s service for the RL agent
├── run\_rl\_benchmark.sh            # Shell script to execute RL vs baseline experiments
├── synthetic\_load\_profile\_60\_chunks.csv  # Workload trace data
├── nginx-deploy.yaml              # Test microservice deployment manifest
└── workload\_steady.yaml           # Descriptor for steady-state load profile

````

---

##  Quickstart Guide

### Prerequisites
- Python 3.x with required packages (see below)
- `kind` Kubernetes cluster or similar local cluster
- Prometheus for metrics collection

### Setup
```bash
# Prepare Kubernetes environment
kind create cluster --config kind-config.yaml
kubectl apply -f prometheus-values.yaml  # or via Helm chart for Prometheus

# Deploy test services and RL agent
kubectl apply -f nginx-deploy.yaml
kubectl apply -f rl-testing-deployment.yaml
kubectl apply -f rl-testing-service.yaml
````

### Run Benchmark

```bash
bash run_rl_benchmark.sh
```

This executes RL experiments and baselines, generating logs and performance CSVs.

### Analyze Results

Run the Jupyter notebook:

```bash
jupyter notebook ML.ipynb
```

It contains end-to-end implementation: environment, DQN training, evaluation, and plots (e.g., latency, reward, pod decision trends).

---

## Key Features

* **Gym-style Kubernetes environment** for autoscaling with Prometheus metrics.
* **DQN-based autoscaler** with step-level logging of reward and SLA accuracy.
* **Baseline comparisons**: Kubernetes HPA and VPA (if enabled).
* **Plots and logs** to support transparency: reward trajectories, latency trends, pod scaling behavior.
* **Reproducible workflow**: uses `run_rl_benchmark.sh` and fixed synthetic workload trace.

---

## Citation & License

A reference to include in academic outputs:

```bibtex
@misc{kubernetes2025docs,
  title        = {Kubernetes Documentation},
  author       = {{The Kubernetes Authors}},
  year         = {2025},
  publisher    = {The Linux Foundation},
  url          = {https://kubernetes.io/docs/},
  note         = {Accessed: 2025-08-09}
}
@misc{google2011clusterdata,
  title        = {Google Cluster Data},
  author       = {Reiss, Charles and Tumanov, Alexey and Ganger, Gregory R and Katz, Randy H and Kozuch, Michael A},
  year         = {2011},
  publisher    = {Google},
  url          = {https://github.com/google/cluster-data},
  note         = {Accessed: 2025-08-09}
}
```


Feel free to let me know if you'd like a QR link or a LaTeX snippet for embedding this repo into your report!

