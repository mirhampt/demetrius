Demetrius, First Librarian of Alexandria
========================================
Demetrius is a collection of software that acts as "librarian" for Alexandria,
a web content library.

Prerequisites & Dependencies
============================
1. [Riak][] >= 1.2 for the Stacks.
2. [Solr][] for the Catalogue. Developed against Solr 4 but may work with earlier versions.
3. A suitable queue back end for Celery. By default [Redis][] is configured for
   development, but you may want RabbitMQ for production.
4. Python 2.7 and virtualenv

If you're not interested in installing all that stuff on your machine, there's
a Vagrantfile that will build a suitable virtual machine for you. Just install
[Vagrant][] and then `vagrant up`. The default ports for all services are mapped to
localhost, namely:

* Redis: localhost:6379
* Riak (HTTP): localhost:8098
* Riak (Protocol Buffers): localhost:8087
* Solr: localhost:8983

Be warned, the virtual machine wants 1GB of memory. Adjust the Vagrantfile if
you want to tweak that.

Python dependencies are documented in `requirements.txt` and may be installed
with pip. If you have virtualenvwrapper (you really should), all you need to
get started is:

    mkvirtualenv -a `pwd` -r requirements.txt demetrius
    vagrant up


[Riak]: http://basho.com/products/riak-overview/
[Solr]: http://lucene.apache.org/solr/
[Redis]: http://redis.io/
[Vagrant]: http://vagrantup.com/
