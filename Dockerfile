FROM postgres:10

# Core build utilities 
apt-get update && apt-get install -f -y software-properties-common build-essential pkg-config git postgresql-server-dev-9.6 

# PostGIS dependency
apt-get install -f -y libproj-dev liblwgeom-dev

# Protobuf-c dependency (requires a non-stable Debian repo)
add-apt-repository "deb http://ftp.debian.org/debian testing main contrib" && apt-get update
apt-get install -y libprotobuf-c-dev=1.2.1-1+b1

# Clonning decodebufs repo
git clone https://github.com/debezium/postgres-decoderbufs.git
cd postgres-decoderbufs

# Re-generating ProtoBuf code
cd proto
protoc-c --c_out=../src/proto pg_logicaldec.proto
cd ..

# Building and installing decoderbufs
make
make install
