kubectl apply -f rl-testing-service.yaml

# Step 1: Kill any process using port 8081 to avoid conflicts
echo "🛑 Checking for processes using port 8081..."
PID_TO_KILL=$(lsof -t -i:8081)
if [ -n "$PID_TO_KILL" ]; then
  echo "⚠️ Killing process(es) using port 8081: $PID_TO_KILL"
  kill $PID_TO_KILL
  sleep 2
else
  echo "✅ No processes using port 8081 found."
fi

# Step 2: Restart deployment (even if unchanged)
echo "🔁 Forcing rollout restart for rl-testing-app..."
kubectl rollout restart deployment rl-testing-app

# Step 3: Wait for pod to be ready
echo "⏳ Waiting for rl-testing-app pod to be ready..."
kubectl wait --for=condition=ready pod -l app=rl-testing-app --timeout=60s

# Step 4: Ensure HPA is clean and recreated
echo "📊 Recreating HPA for rl-testing-app..."
kubectl delete hpa rl-testing-app --ignore-not-found
kubectl autoscale deployment rl-testing-app --cpu-percent=50 --min=1 --max=10

# Step 5: Start port-forwarding the app service
echo "🌐 Port-forwarding rl-testing-service → http://localhost:8081 ..."
kubectl port-forward svc/rl-testing-service 8081:80 &
APP_PID=$!
sleep 3

echo "📈 Current HPA status:"
kubectl get hpa rl-testing-app

