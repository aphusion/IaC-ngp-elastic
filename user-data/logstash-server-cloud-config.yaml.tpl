#cloud-config

coreos:
  etcd2:
    discovery: https://discovery.etcd.io/a8b57a19287d1030ff94693ad5fab642
    advertise-client-urls: http://$private_ipv4:2379,http://$private_ipv4:4001
    initial-advertise-peer-urls: http://$private_ipv4:2380
    listen-client-urls: http://0.0.0.0:2379,http://0.0.0.0:4001
    listen-peer-urls: http://$private_ipv4:2380
  fleet:
    public-ip: $private_ipv4   # used for fleetctl ssh command
    metadata: "mesos-node=agent"
  units:
    - name: etcd2.service
      command: start
    - name: fleet.service
      command: start
    - name: |-
        elk-logstash.service
      command: |-
        start
      content: |
        [Unit]
        Description=Logstash
        After=docker.service
        Requires=docker.service
        [Service]
        TimeoutStartSec=0
        ExecStartPre=-/bin/sh -c "docker kill %p"
        ExecStartPre=-/bin/sh -c "docker rm -f %p 2> /dev/null"
        ExecStartPre=/bin/sh -c "docker pull ${logstash_image}"
        ExecStart=/bin/sh -c "docker run --rm --name %p --privileged -p 5044:5044 -e "ELASTICSEARCH_URI=${elasticsearch_uri}" -e "ELASTICSEARCH_START=0" -e "KIBANA_START=0" ${logstash_image}"
        ExecStop=/bin/sh -c "docker stop %p"
        RestartSec=5
        Restart=always
        [X-Fleet]
        Global=true
