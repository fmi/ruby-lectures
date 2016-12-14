dump_env = proc do |env|
  body = env.map { |key, value| "#{key}: #{value}" }.join("\n")
  [200, {'Content-Type'   => 'text/plain'}, [body]]
end

run dump_env
