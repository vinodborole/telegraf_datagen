# telegraf_datagen

Data generator for Telegraf socket_listener


## Usage

1. Setup Telegraf with the socket_listener input plugin
```
[[inputs.socket_listener]]
  service_address = "tcp://:8094"
  data_format = "influx"
```

2. Build

```
docker build -t telegraf_datagen .

```

3. Use

```
docker run -d -p 8080:8080 telegraf_datagen

```
