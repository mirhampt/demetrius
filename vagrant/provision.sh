# Install Redis, older libssl (required by riak 1.2.1), and the JDK for Solr
apt-get -qy update #&& apt-get -qy dist-upgrade
apt-get -qy install redis-server libssl0.9.8 curl wget default-jdk vim

# Use local files if they have already been fetched, otherwise fetch them now.
echo "Downloading Riak and Solr. You may want to take a coffee break..."
cd /vagrant/vagrant
[ -f riak_1.2.1-1_i386.deb ] || wget -q http://downloads.basho.com.s3-website-us-east-1.amazonaws.com/riak/CURRENT/ubuntu/lucid/riak_1.2.1-1_i386.deb

[ -f apache-solr-4.0.0.tgz ] || wget -q http://mirrors.ibiblio.org/apache/lucene/solr/4.0.0/apache-solr-4.0.0.tgz

# Install Riak
dpkg -i riak_1.2.1-1_i386.deb

# Install solr
mkdir -p /opt
cd /opt
tar -xzf /vagrant/vagrant/apache-solr-4.0.0.tgz

# Override default configurations to do what I want
# TODO Copy solr configuration (solrconfig.xml, schema.xml) into place
cp /vagrant/vagrant/upstart/solr4.conf /etc/init/solr4.conf
cp /vagrant/vagrant/riak/* /etc/riak/
cp /vagrant/vagrant/redis/* /etc/redis/

service redis-server restart
service solr4 restart
service riak restart

echo "All done now"

