# ContainerLab - Scripts

[Back](/docs/containerlab/ContainerLab_Main.md)

A set of scripts in ``/ndfc-evpn/ContainerLab/checks/`` can be used to monitor the lab as it's starting up.

They each run ``docker logs`` to query the n9000v container logs.

## Example

```bash
arobel@cvd-3:~/repos/ndfc-evpn/ContainerLab/checks$ sudo ./check_startup_complete 
[sudo] password for arobel: 
2023-06-22 19:10:37,304: launch     INFO     Startup complete in: 0:35:24.851042
2023-06-22 19:10:41,602: launch     INFO     Startup complete in: 0:35:28.634657
2023-06-22 19:10:34,202: launch     INFO     Startup complete in: 0:23:21.188693
2023-06-22 19:10:32,054: launch     INFO     Startup complete in: 0:23:18.663389
2023-06-22 19:07:19,657: launch     INFO     Startup complete in: 0:32:06.190889
2023-06-22 19:07:17,158: launch     INFO     Startup complete in: 0:32:03.462280
2023-06-22 19:07:33,618: launch     INFO     Startup complete in: 0:20:19.580804
2023-06-22 19:07:22,851: launch     INFO     Startup complete in: 0:20:08.799408
2023-06-22 19:07:08,152: launch     INFO     Startup complete in: 0:31:54.457157
2023-06-22 19:05:58,707: launch     INFO     Startup complete in: 0:30:45.767586
2023-06-22 19:07:13,142: launch     INFO     Startup complete in: 0:19:59.082763
2023-06-22 19:05:53,817: launch     INFO     Startup complete in: 0:18:40.461799
2023-06-22 19:05:54,121: launch     INFO     Startup complete in: 0:12:42.034197
arobel@cvd-3:~/repos/ndfc-evpn/ContainerLab/checks$  
```