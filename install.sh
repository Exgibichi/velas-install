# устанавливаем парити
bash <(curl https://get.parity.io -L)
mkdir -p ./data
cp config.example.toml config.toml
# генерируем пароль
echo date +%s | sha256sum | base64 | head -c 32 >> password
# генерируем ключи и записываем в конфиг
parity --config config.toml account new >> stake_acc
parity --config config.toml account new >> signer_acc
sed -i 's/${stake_acc}/'$(cat stake_acc)'/g' config.toml
sed -i 's/#unlock/unlock/g' config.toml
sed -i 's/${signer_acc}/'$(cat signer_acc)'/g' config.toml
sed -i 's/#engine_signer/engine_signer/g' config.toml