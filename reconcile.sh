#!/bin/bash

oc delete workflow $(oc get workflows -o=jsonpath='{.items[?(@.status.phase=="Succeeded")].metadata.name}')

while :
do
    for w in $(oc get workflows -o=jsonpath='{.items[?(@.status.phase=="Error")].metadata.name}' ); do
        argo retry $w
        sleep 7
        oc delete workflow $(oc get workflows -o=jsonpath='{.items[?(@.status.phase=="Succeeded")].metadata.name}')
    done

    sleep 15
done

#end.
