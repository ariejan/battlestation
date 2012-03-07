Battlestation.plan do
  dependency :redis do
    executable 'redis-server'
    process 'redis-server'
  end
end
