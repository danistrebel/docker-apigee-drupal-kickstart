apiVersion: apps/v1
kind: Deployment
metadata:
  name: apigee-dev-portal
spec:
  selector:
    matchLabels:
      app: apigee-dev-portal
  template:
    metadata:
      labels:
        app: apigee-dev-portal
    spec:
      containers:
      - name: apigee-dev-portal
        image: gcr.io/$PROJECT_ID/apigee/dev-portal:drupal8
        env:
        - name: APIGEE_EDGE_AUTH_TYPE
          value: basic
        - name: APIGEE_EDGE_ORGANIZATION
          valueFrom:
            secretKeyRef:
              name: apigee-credentials
              key: org
        - name: APIGEE_EDGE_USERNAME
          valueFrom:
            secretKeyRef:
              name: apigee-credentials
              key: username
        - name: APIGEE_EDGE_PASSWORD
          valueFrom:
            secretKeyRef:
              name: apigee-credentials
              key: password
        - name: APIGEE_EDGE_ENDPOINT
          valueFrom:
            secretKeyRef:
              name: apigee-credentials
              key: endpoint        
        resources:
          limits:
            memory: "128Mi"
            cpu: "500m"
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: apigee-dev-portal
spec:
  selector:
    app: apigee-dev-portal
  ports:
  - port: 80
    targetPort: 80

