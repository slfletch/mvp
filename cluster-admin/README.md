## Cluster-admin folder will be responsible for creating the namespace admin required for running any CI/CD.

    For example: 
        Creation of namespace, service-accounts, roles, rolebindings, etc.
    Each tenant will be given a kubeconfig specific to the namespace created for them.
            
        cluster: kubernetes
        namespace: demo
