cleanup() {
  redis-cli shutdown
  rm -f "${HOME}/bin/redis-"*
  rm -rf "${HOME}/redis"
  rm -rf "${HOME}/cache/redis-${REDIS_VERSION}"
  rm -f "${HOME}/cache/redis-${REDIS_VERSION}.tar.gz"
  unset REDIS_VERSION
  sudo systemctl start redis-server
}
