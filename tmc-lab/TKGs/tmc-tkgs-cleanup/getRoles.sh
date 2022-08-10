#!/bin/bash
# Author: Ben Todd
# Use: Run this to grab all the existing roles in TMC and output file to be used for role cleanup script

# Delete old input file for cleanup
rm ./roles.txt
# Get Roles
tmc iam role list > roles.txt

#Cleanup File to remove working role and system roles from list for delete
sed -i 's/  //g' roles.txt # removes leading spaces
sed -i '/NAME/d' roles.txt # Removes Column Header
sed -i '/lfl.workspace.admin/d' roles.txt # Removes Working Role needed for class to operate properly
# System Roles             
sed -i '/cluster.admin/d' roles.txt              
sed -i '/cluster.edit/d' roles.txt
sed -i '/clustergroup.admin/d' roles.txt
sed -i '/clustergroup.edit/d' roles.txt
sed -i '/clustergroup.iam.view/d' roles.txt                     
sed -i '/clustergroup.view/d' roles.txt
sed -i '/cluster.view/d' roles.txt   
sed -i '/credential.admin/d' roles.txt 
sed -i '/credential.edit/d' roles.txt
sed -i '/credential.view/d' roles.txt
sed -i '/managementcluster.admin/d' roles.txt
sed -i '/managementcluster.edit/d' roles.txt
sed -i '/managementcluster.iam.view/d' roles.txt
sed -i '/managementcluster.view/d' roles.txt
sed -i '/^namespace.admin/d' roles.txt
sed -i '/^namespace.create/d' roles.txt 
sed -i '/^namespace.edit/d' roles.txt 
sed -i '/^namespace.view/d' roles.txt 
sed -i '/organization.admin/d' roles.txt
sed -i '/organization.backuplocation.edit/d' roles.txt
sed -i '/organization.backuplocation.view/d' roles.txt
sed -i '/organization.credential.admin/d' roles.txt
sed -i '/organization.credential.iam.view/d' roles.txt
sed -i '/organization.credential.view/d' roles.txt
sed -i '/organization.edit/d' roles.txt
sed -i '/organization.iam.view/d' roles.txt
sed -i '/organization.policytemplate.edit/d' roles.txt          
sed -i '/organization.view/d' roles.txt
sed -i '/provisioner.admin/d' roles.txt
sed -i '/provisioner.credential.admin/d' roles.txt
sed -i '/provisioner.credential.edit/d' roles.txt
sed -i '/provisioner.credential.view/d' roles.txt
sed -i '/provisioner.edit/d' roles.txt 
sed -i '/provisioner.iam.view/d' roles.txt
sed -i '/provisioner.view/d' roles.txt 
sed -i '/workspace.admin/d' roles.txt
sed -i '/workspace.edit/d' roles.txt 
sed -i '/workspace.iam.view/d' roles.txt
sed -i '/workspace.view/d' roles.txt
#Open Input File for Confermation in VSCode
code roles.txt