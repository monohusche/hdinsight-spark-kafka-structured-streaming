$creds = Get-Credential -UserName "admin" -Message "Enter the HDInsight login"
$clusterName = Read-Host -Prompt "Enter the Kafka cluster name"
$resp = Invoke-WebRequest -Uri "https://$clusterName.azurehdinsight.net/api/v1/clusters/$clusterName/services/ZOOKEEPER/components/ZOOKEEPER_SERVER" `
    -Credential $creds `
  -UseBasicParsing
$respObj = ConvertFrom-Json $resp.Content
$zkHosts = $respObj.host_components.HostRoles.host_name[0..1]
($zkHosts -join ":2181,") + ":2181"
