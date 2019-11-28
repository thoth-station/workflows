#!/bin/bash

oc delete workflow $(oc get workflows -o=jsonpath='{.items[?(@.status.phase=="Succeeded")].metadata.name}')

for w in $( oc get workflows -o=jsonpath='{.items[?(@.status.phase=="Error")].metadata.name}' ); do
    argo retry $w
    sleep 7
done

#end.
