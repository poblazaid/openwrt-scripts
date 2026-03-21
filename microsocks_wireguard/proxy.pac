function FindProxyForURL(url, host) {
    var useSocks = ["*imgur.com"];

    for (var i= 0; i < useSocks.length; i++) {
        if (shExpMatch(host, useSocks[i])) {
            return "SOCKS5 192.168.1.254:3189";
        }
    }

    return "DIRECT";
}
