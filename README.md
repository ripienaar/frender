What?
=====

A helper to render files using data and templates.

As I am moving as much as possible of my service components away from
traditional CM and towards containers I find I do need sometimes to construct
complex config files like those in nameservers listing a bunch of zones.

This is best done with templates and data like you would do in Puppet using
Hiera and Templates.  But in a world without those tools something new is
needed.

Rendering is done using the ```Tilt``` Gem so you can use many types of template
engine, examples here use ERB.  Just name your templates according to the tilt
requirements - see ```tilt -l```

Usage?
------

Lets say we want to render bind config files for 2 servers, one master and two slaves.
The full working example is in the ```example``` dir here including it's output.

The master is on ```192.0.2.10``` and the slaves are ```198.51.100.10``` and ```203.0.113.10```
and we want to notify the slaves both specifically if a zone is updated.

You need to tell the tool which files you wish to create using what data and
what templates:

```yaml
:frender:
  :yaml_scope: zones.yaml

  :files:
    "conf/named_slave_zones":
      :template: "templates/slave_zones.erb"

    "conf/named_master_zones":
      :template: "templates/master_zones.erb"
```

For the moment just one scope is supported, I guess it might make sense to support
per file scopes and definitely per file mode settings.  The only scope type is yaml.

You need to create data and templates, see the ```example``` directory for full working
examples.  Render them with:


```
$ frender frender.yaml
Reading specification file frender.yaml
Reading scope file zones.yaml
Rendering file conf/named_slave_zones using template templates/slave_zones.erb
Rendering file conf/named_master_zones using template templates/master_zones.erb
```

You can override the scope being used using ```--scope```.

Contact?
----

R.I.Pienaar / rip@devco.net / @ripienaar / http://devco.net/
