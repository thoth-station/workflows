# workflows
A set of example Argo workflows.


## Provisioning

To provision Argo, we use the [Argo Workflows ansible role](https://github.com/CermakM/ansible-role-argo-workflows) and the [provisioning playbook](/playbooks/provision.yml).

You will be asked a namespace to with the Argo should be provisioned and a password to the vault. Run:

```bash
ansible-playbook playbooks/provision.yml --ask-vault-pass
```

## Submitting workflows with Argo CLI

See [How to write Argo Workflows](https://github.com/argoproj/argo/blob/master/examples/README.md) for the getting started.

To submit a more complicated workflow (i.e., the [inspection](/examples/inspection.yaml)), first make sure that all the templates have been created.

```bash
kubectl create --namespace ${ARGO_NAMESPACE} -f examples/templates
```

And now to submit the [inspection](/examples/inspection.yaml) workflow using the [parameters](/examples/parameters.json) file:

```bash
argo submit --watch examples/inspection.yaml \
    --name inspection-131719234 \
    -p batch-size=${BATCH_SIZE} \
    -p parallelism=${PARALLELISM} \
    -p thoth-infra-namespace=${ARGO_NAMESPACE} \
    -f examples/parameters.json
```

## Submitting workflows via Python

See examples [notebooks](https://github.com/thoth-station/notebooks/blob/master/notebooks/workflows/amun-inspection-workflow.ipynb) or check [thoth.common.workflows](https://github.com/thoth-station/common/blob/public-workflow-methods/thoth/common/workflows.py).

