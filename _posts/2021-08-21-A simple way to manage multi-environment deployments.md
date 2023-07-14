_Originally posted Jun 08 2021 by James Johnston on flywaydb.org_

https://www.youtube.com/watch?v=sG83tMn7vqE

Often when working with Flyway (and release automation in general) you will have a set of deployables - and a chain of environments these need to be delivered to in order. More often than not, these are along the lines of

*   Dev
*   Continuous Integration
*   Staging
*   Production

In this quick tutorial we are going to look at an easy way to handle that within Flyway.

## Multiple config files

By default, Flyway will load a conf file from `conf/flyway.conf`. When looking at multiple environments, there are a number of options open to us. For simplicity sake, we will stick to multiple config files, configuring which one to use via command line.

One simple trick can streamline this process; the statement before, about loading a conf file by default, is true even when an alternative config is specified. This means we can have all of our non environment specific set up within the `conf/flyway.conf` config, and the environment specific details in a relevant config file.

For example purposes, I will be demonstrating this with a number of H2 file databases:

**conf/env\_dev.conf**  
`flyway.url=jdbc:hsqldb:file:devdb/db`  
  
**conf/env\_ci.conf**  
`flyway.url=jdbc:hsqldb:file:cidb/db`  
  
**conf/env\_staging.conf**  
`flyway.url=jdbc:hsqldb:file:stagingdb/db`  
  
**conf/env\_live.conf**  
`flyway.url=jdbc:hsqldb:file:livedb/db`  
  
Now we can simply specify the environment we are targeting with a command such as:  
  
`.\flyway info -configFiles=".\conf\env_dev.conf" -teams`  
  
Which will run info against the **dev** environment. To then target the **CI** environment, it is as simple as:  
  
`.\flyway info -configFiles=".\conf\env_ci.conf" -teams`  
  
As you can see in these examples, I have also specified the `-teams` flag as I am using teams edition (trial available [here](https://www.red-gate.com/products/flyway/teams/ )) even though the trial key is not specified in the environment configs; it is configured within the main `conf/flyway.conf` file - which is read in by default (without being specified).

## Conclusion

We have shown flexibility with Flyway's conf files makes managing multiple environments trivial without having to duplicate standardized config across many conf files, eliminating drift. Specifying this config file could be configured within your CI to be replaced depending on the target environment making deployment to each environment _ingeniously simple_.