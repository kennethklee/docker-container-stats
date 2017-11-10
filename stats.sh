node -e "
    require('docker-stats')({statsinterval: 1}).pipe(new (require('stream').Writable)({
        objectMode:true,
        write: (c, e, cb) => {
            let name = c.name.split('.').slice(0, 2).join('-')
            console.log(name + '.CPU', c.stats.cpu_stats.cpu_usage.cpu_percent);
            console.log(name + '.Memory', c.stats.memory_stats.usage);
            console.log(name + '.RX', c.stats.networks.eth0.rx_bytes);
            console.log(name + '.TX', c.stats.networks.eth0.tx_bytes);
            cb()
        }
    }))
" | turtle-race