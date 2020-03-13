#
apt install curl -y
# need to to our repo
bash <(curl https://get.parity.io -L)
mkdir -p ./data
# need to get config example from our repo
cp config.example.toml config.toml
# generate password
echo date +%s | sha256sum | base64 | head -c 32 >> password
# generate keys and put in config
parity --config config.toml account new >> stake_acc
parity --config config.toml account new >> signer_acc
sed -i 's/${stake_acc}/'$(cat stake_acc)'/g' config.toml
sed -i 's/#unlock/unlock/g' config.toml
sed -i 's/${signer_acc}/'$(cat signer_acc)'/g' config.toml
sed -i 's/#engine_signer/engine_signer/g' config.toml
